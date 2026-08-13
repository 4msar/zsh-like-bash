HISTCONTROL="ignoreboth:erasedups"

HISTSIZE=10000
HISTFILESIZE=20000

shopt -s histappend
shopt -s cmdhist
shopt -s lithist

# Prefix-based history search
if [[ -f "$HOME/.bash/inputrc" ]]; then
    bind -f "$HOME/.bash/inputrc"
fi
