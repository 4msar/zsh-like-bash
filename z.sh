# ============================================================
# Custom z - directory jumper for Bash
# ============================================================

Z_DATA="$HOME/.bash/z-data"

mkdir -p "$Z_DATA"

touch "$Z_DATA/directories"


# ------------------------------------------------------------
# Add current directory to database
# ------------------------------------------------------------

__z_add() {
    local dir="$PWD"

    # Don't save these
    [[ "$dir" == "/" ]] && return
    [[ "$dir" == "$HOME" ]] && return

    # Remove duplicate entry
    grep -Fxv "$dir" "$Z_DATA/directories" > "$Z_DATA/.tmp" 2>/dev/null
    printf '%s\n' "$dir" >> "$Z_DATA/.tmp"
    mv "$Z_DATA/.tmp" "$Z_DATA/directories"
}


# ------------------------------------------------------------
# Find directory
# ------------------------------------------------------------

__z_find() {

    local query="$*"
    local dir
    local score
    local best=""
    local best_score=0

    while IFS= read -r dir; do

        [[ -d "$dir" ]] || continue

        score=0

        # Every search term must exist somewhere in the path
        local word
        local match=1

        for word in $query; do
            if [[ "$dir" == *"$word"* ]]; then
                ((score += 10))
            else
                match=0
                break
            fi
        done

        (( match == 0 )) && continue

        # Prefer directories closer to the end of the path
        [[ "$dir" == *"/$query" ]] && ((score += 20))

        # Prefer shorter paths
        score=$((score * 1000 - ${#dir}))

        if (( score > best_score )); then
            best_score=$score
            best="$dir"
        fi

    done < "$Z_DATA/directories"

    [[ -n "$best" ]] && printf '%s' "$best"
}


# ------------------------------------------------------------
# z command
# ------------------------------------------------------------

z() {

    # z
    # Go home
    if [[ $# -eq 0 ]]; then
        cd "$HOME" || return
        return
    fi


    # z -
    # Previous directory
    if [[ "$1" == "-" && $# -eq 1 ]]; then
        cd - || return
        return
    fi


    # z /absolute/path
    if [[ "$1" == /* ]]; then
        cd "$1" || return
        return
    fi


    # z ~/path
    if [[ "$1" == "~/"* ]]; then
        cd "$1" || return
        return
    fi


    # Search database
    local target

    target="$(__z_find "$@")"


    if [[ -n "$target" ]]; then
        cd "$target" || return
        return
    fi


    echo "z: no matching directory"
    return 1
}
