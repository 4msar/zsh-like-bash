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
