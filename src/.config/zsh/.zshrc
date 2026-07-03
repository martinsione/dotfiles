ZSH_CONFIG_DIR=$HOME/.config/zsh

### PATH (set early)
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$BUN_INSTALL/bin:$PNPM_HOME:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.codeium/windsurf/bin:$PATH"

### Environment
export LOCALHOST_KEY="$HOME/.certs/localhost-key.pem"
export LOCALHOST_CERT="$HOME/.certs/localhost.pem"
export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"

### Completion (cached - only rebuild once daily)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

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

### pyenv (lazy loaded)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
_pyenv_init() {
  unfunction python python3 pip pip3 pyenv 2>/dev/null
  eval "$(pyenv init - zsh)"
}
for cmd in python python3 pip pip3 pyenv; do
  eval "$cmd() { _pyenv_init && $cmd \"\$@\" }"
done

### Prompt
eval "$(starship init zsh)"

# bun completions
[ -s "/Users/martin-aleph/.bun/_bun" ] && source "/Users/martin-aleph/.bun/_bun"

# Wrangler Docker config
export WRANGLER_DOCKER_BIN=/opt/homebrew/bin/docker

# opencode
export PATH=/Users/martin-aleph/.opencode/bin:$PATH

# fx CLI
export PATH="/Users/martin-vercel/.fx/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/martin-vercel/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# BEGIN: socket firewall aliases (managed by Iru)
alias npm="sfw npm"
alias pnpm="sfw pnpm"
alias bun="sfw bun"
# END: socket firewall aliases (managed by Iru)
