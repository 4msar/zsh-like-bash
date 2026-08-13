#!/usr/bin/env bash
#
# zsh-like-bash installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/4msar/zsh-like-bash/main/install.sh | bash
#
set -euo pipefail

REPO_URL="https://github.com/4msar/zsh-like-bash.git"
INSTALL_DIR="$HOME/.bash"
BASHRC="$HOME/.bashrc"
MARKER_START="# >>> zsh-like-bash >>>"
MARKER_END="# <<< zsh-like-bash <<<"

if ! command -v git >/dev/null 2>&1; then
    echo "error: git is required but not installed." >&2
    exit 1
fi

if [[ -d "$INSTALL_DIR/.git" ]]; then
    echo "Existing installation found at $INSTALL_DIR, updating..."
    git -C "$INSTALL_DIR" pull --ff-only
else
    echo "Cloning zsh-like-bash into $INSTALL_DIR..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

touch "$BASHRC"

if grep -Fq "$MARKER_START" "$BASHRC"; then
    echo "$BASHRC already configured, skipping."
else
    {
        echo ""
        echo "$MARKER_START"
        cat "$INSTALL_DIR/init"
        echo "$MARKER_END"
    } >> "$BASHRC"
    echo "Added init snippet to $BASHRC"
fi

echo "Done. Run 'source ~/.bashrc' or open a new shell to start using it."
