ZSH_CONFIG_DIR=$HOME/.config/zsh

### PATH (set early)
# ~/.zprofile normally runs brew shellenv; only redo it when brew isn't on PATH yet.
[[ $OSTYPE == darwin* ]] && (( ! $+commands[brew] )) && [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$BUN_INSTALL/bin:$PNPM_HOME:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.fx/bin:$PATH"

### Environment
# ssh doesn't forward COLORTERM, so remote apps fall back to 256 colors (Claude's orange turns pink).
[[ -n $SSH_CONNECTION && -z $COLORTERM ]] && export COLORTERM=truecolor
if [[ $OSTYPE == darwin* ]]; then
  export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"
  export WRANGLER_DOCKER_BIN=/opt/homebrew/bin/docker
  # Gateway key lives in the Keychain (~16ms per lookup, so only the one opencode reads)
  export AI_GATEWAY_API_KEY="$(/usr/bin/security find-generic-password -s 'Vercel AI Gateway' -a 'vercel-desktop-key' -w 2>/dev/null)"
fi

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

# Source a tool's generated init script, cached per binary path so an upgrade (new path) regenerates it
_cached_init() {
  local bin=${commands[$1]:A}
  [[ -n $bin ]] || return
  local cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/init/${bin//\//%}.zsh
  [[ -s $cache ]] || { mkdir -p ${cache:h} && "$@" >| $cache } || return
  source $cache
}

### fzf (Ctrl-R history, Ctrl-T files, Alt-C cd)
_cached_init fzf --zsh

### Prompt
_cached_init starship init zsh --print-full-init

# BEGIN: socket firewall aliases (managed by Iru)
alias npm="sfw npm"
alias pnpm="sfw pnpm"
alias bun="sfw bun"
# END: socket firewall aliases (managed by Iru)
(( $+commands[sfw] )) || unalias npm pnpm bun 2>/dev/null

### Machine-local overrides (untracked local.sh; per-machine PATH/aliases/unaliases)
[ -f "$ZSH_CONFIG_DIR/config/local.sh" ] && source "$ZSH_CONFIG_DIR/config/local.sh"

[ -r ~/.config/vboard/factory-bypass ] && export VERCEL_AUTOMATION_BYPASS_SECRET="$(<~/.config/vboard/factory-bypass)"
