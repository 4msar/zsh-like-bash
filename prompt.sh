# ==============================
# Zsh-like Bash prompt
# ==============================

RESET='\[\e[0m\]'
BLUE='\[\e[1;34m\]'
CYAN='\[\e[1;36m\]'
GREEN='\[\e[1;32m\]'
MAGENTA='\[\e[1;35m\]'
RED='\[\e[1;31m\]'
DIM='\[\e[2m\]'


# Shorten long paths
__prompt_path() {
    local path="$PWD"

    if [[ "$path" == "$HOME"* ]]; then
        path="~${path#$HOME}"
    fi

    local max=50

    if (( ${#path} <= max )); then
        printf '%s' "$path"
        return
    fi

    printf '%s/.../%s' \
        "${path%%/*}" \
        "${path##*/}"
}


# Git information
__prompt_git() {

    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch status upstream ahead behind sync

    branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    if [[ -z "$branch" ]]; then
        branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi

    if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
        status="✗"
    else
        status="✓"
    fi

    upstream=$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)

    ahead=0
    behind=0

    if [[ -n "$upstream" ]]; then
        read -r behind ahead <<< "$(
            git rev-list --left-right --count \
                "$upstream...HEAD" 2>/dev/null
        )"
    fi

    sync=""

    (( ahead > 0 )) && sync+=" ↑$ahead"
    (( behind > 0 )) && sync+=" ↓$behind"

    printf '%s[🌿 %s %s%s]%s' \
        "$MAGENTA" \
        "$branch" \
        "$status" \
        "$sync" \
        "$RESET"
}


# Command timing
__prompt_start=$SECONDS
__prompt_duration=0


__prompt_timer_start() {
    __prompt_start=$SECONDS
}


__prompt_timer_end() {
    __prompt_duration=$((SECONDS - __prompt_start))
}


# Prompt
__prompt_update() {

    __prompt_exit=$?

    # Remember current directory for custom z
    if declare -F __z_add >/dev/null 2>&1; then
        __z_add
    fi

    __prompt_timer_end

    local path git duration exit_status prompt_color

    path="$(__prompt_path)"
    git="$(__prompt_git)"

    duration=""

    if (( __prompt_duration >= 1 )); then
        duration="${DIM} · ${__prompt_duration}s${RESET}"
    fi

    exit_status=""

    if (( __prompt_exit != 0 )); then
        exit_status="${RED} ✗ ${__prompt_exit}${RESET}"
        prompt_color="$RED"
    else
        prompt_color="$GREEN"
    fi

    PS1="${CYAN}╭─ ${BLUE}${path}${RESET}"

    [[ -n "$git" ]] && PS1+=" ${git}"

    PS1+=" ${duration}${exit_status}"$'\n'
    PS1+="${prompt_color}╰─❯ ${RESET}"

    __prompt_timer_start
}


PROMPT_COMMAND="__prompt_update"
