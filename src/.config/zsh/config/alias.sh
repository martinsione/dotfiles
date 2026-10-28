(( $+commands[nvim] )) && alias vim="nvim"
alias v="nvim"
[[ $OSTYPE == darwin* ]] && c() { open -a Cursor "${@:-.}"; }

# Clipboard: pbcopy on macOS, OSC 52 elsewhere (works over SSH and through tmux set-clipboard)
if (( $+commands[pbcopy] )); then
  alias clip="pbcopy"
else
  clip() { printf '\e]52;c;%s\a' "$(base64 | tr -d '\n')"; }
fi

alias ..="cd .."
alias ls="eza --group-directories-first"
alias ll="eza -la --group-directories-first"
alias tree="eza --tree"

# Files
alias md="mkdir -pv"
# Prompting copies stall agent shells (Claude Code sets CLAUDECODE), so only for a person's shell.
if [[ -o interactive && -z $CLAUDECODE ]]; then
  alias cp="cp -iv"
  alias mv="mv -iv"
  alias rm="rm -iv"
fi

function kill_port() {
  local pids=$(lsof -t -i:"$1")
  [[ -n $pids ]] && kill ${=pids} || echo "nothing listening on :$1"
}
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
alias pr="gh pr view --web"
alias prm="gh pr list --author '@me'"
alias prc="gh pr view --json url -q .url | clip"
alias prb="git branch --show-current | clip"

## Tmux
alias ta="tmux new-session -A -s"
alias tls="tmux ls"
alias tks="tmux kill-session -t"

## Claude
# One config dir (~/.claude). Plain `claude` uses the Vercel AI Gateway (apiKeyHelper in settings.json);
# `pclaude` blanks the helper and base URL so the claude.ai subscription login is used instead.
alias pclaude='env -u ANTHROPIC_BASE_URL -u ANTHROPIC_AUTH_TOKEN -u ANTHROPIC_API_KEY claude --settings '"'"'{"apiKeyHelper":"","env":{"ANTHROPIC_BASE_URL":""}}'"'"
