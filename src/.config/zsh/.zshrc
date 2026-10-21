ZSH_CONFIG_DIR=$HOME/.config/zsh

### PATH (set early)
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$BUN_INSTALL/bin:$PNPM_HOME:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.fx/bin:$HOME/.codeium/windsurf/bin:$PATH"

### Environment
export LOCALHOST_KEY="$HOME/.certs/localhost-key.pem"
export LOCALHOST_CERT="$HOME/.certs/localhost.pem"
export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"
export WRANGLER_DOCKER_BIN=/opt/homebrew/bin/docker

### Completion (cached - only rebuild once daily)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
autoload -Uz compinit
# (#q) needs extended_glob, and compinit leaves a still-valid dump untouched, so touch it to restart the 24h clock.
() {
  setopt local_options extended_glob
  if [[ -n $1(#qN.mh+24) ]]; then
    compinit -d $1 && touch $1
  else
    compinit -C -d $1
  fi
} ${ZDOTDIR:-$HOME}/.zcompdump

### History (macOS sets these in /etc/zshrc; Linux leaves history off entirely)
HISTFILE=$ZSH_CONFIG_DIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history share_history hist_ignore_all_dups hist_ignore_space hist_reduce_blanks

### Config
source $ZSH_CONFIG_DIR/config/alias.sh
source $ZSH_CONFIG_DIR/config/scripts.sh
source $ZSH_CONFIG_DIR/config/worktree.sh

### Plugins (autosuggestions before syntax-highlighting)
source $ZSH_CONFIG_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### Tool completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

### fnm (node version manager)
eval "$(fnm env --shell=zsh --use-on-cd)"

### fzf (Ctrl-R history, Ctrl-T files, Alt-C cd)
(( $+commands[fzf] )) && source <(fzf --zsh)

### pyenv (lazy loaded)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if (( $+commands[pyenv] )); then
  _pyenv_init() {
    unfunction python python3 pip pip3 pyenv 2>/dev/null
    eval "$(pyenv init - zsh)"
  }
  for cmd in python python3 pip pip3 pyenv; do
    eval "$cmd() { _pyenv_init && $cmd \"\$@\" }"
  done
fi

### Prompt
eval "$(starship init zsh)"

# BEGIN: socket firewall aliases (managed by Iru)
alias npm="sfw npm"
alias pnpm="sfw pnpm"
alias bun="sfw bun"
# END: socket firewall aliases (managed by Iru)

### Machine-local overrides (untracked local.sh; per-machine PATH/aliases/unaliases)
[ -f "$ZSH_CONFIG_DIR/config/local.sh" ] && source "$ZSH_CONFIG_DIR/config/local.sh"

[ -r ~/.config/vboard/factory-bypass ] && export VERCEL_AUTOMATION_BYPASS_SECRET="$(<~/.config/vboard/factory-bypass)"
