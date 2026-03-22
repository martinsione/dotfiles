[ -x "$(command -v nvim)" ] && alias vim="nvim"
alias v="nvim"
alias c="open $1 -a \"Cursor\""

alias ..="cd .."
alias ls="eza --group-directories-first"
alias ll="eza -la --group-directories-first"

# Files
alias cp="cp -iv"
alias md="mkdir -pv"
alias mv="mv -iv"
alias rm="rm -iv"

function kill_port() { kill -9 $(lsof -t -i:"$1"); }
alias kp=kill_port

# Git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gco="git checkout"
alias gc!="git commit -v --amend"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gd="git diff"
alias gcl="git clone"
alias glg="git lg"
alias gp='git push'
alias gP='git pull'
alias gr='git remote'
alias gm='git merge'
alias gs="git st"

## Tmux
alias ta="tmux new-session -A -s"
alias tls="tmux ls"
alias tks="tmux kill-session -t"

alias claude="claude --allow-dangerously-skip-permissions"
