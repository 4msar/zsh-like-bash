# General
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias cls='clear'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias grep='grep --color=auto'

# Git
alias gs='git status'
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gsw='git switch'
alias gcb='git switch -c'
alias gr='git restore'
alias grs='git restore --staged'


# Get my current ip address details
alias myip='curl https://ipinfo.io'
alias myipconfig='curl https://ifconfig.me/all.json | jq'
