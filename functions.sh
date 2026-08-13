# Usefull functions for bash


# Generate a password
function generate_password() {
    openssl rand -hex 16
}

# Git cleanup branches
function clear_git_branches(){
    git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}

# Misc: Remove .DS_Store files
function remove_ds_store() {
  find . -type f -name ".DS_Store" -delete
}

function zlb-update() {
    local current_dir=$(pwd)

    # get this file directory path
    local script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

    echo "Updating zsh-like-bash from $script_path"
    echo ""

    # goto the script path
    cd "$script_path" || return

    # git pull the latest changes
    git pull origin main --quiet

    echo ""
    echo "zsh-like-bash updated successfully!"

    cd "$current_dir" || return
}

function zlb-help() {

    # check for --aliases argument

    if [[ "$1" == "--aliases" ]]; then
        echo "Available aliases:"
        echo "  z - Jump to a frequently used directory"
        sed -n 's/^[[:space:]]*alias[[:space:]]*//p' "$ZSH_LIKE_BASH_DIR/aliases.sh"
        return
    fi

    echo "zsh-like-bash - A collection of useful bash functions and styles"
    echo ""
    echo ""
    echo "Available functions:"
    echo "  generate_password - Generate a random password"
    echo "  clear_git_branches - Cleanup git branches that are gone"
    echo "  remove_ds_store - Remove .DS_Store files from the current directory"
    echo "  zlb-update - Update zsh-like-bash to the latest version"
    echo "  zlb-help - Show this help message"

    echo ""
    echo ""
    echo "Aliases:"
    echo "  z - Jump to a frequently used directory"
    echo "  zlb-help --aliases - Show available aliases"
}
