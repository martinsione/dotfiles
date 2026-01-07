ZSH_CONFIG_DIR=$HOME/.config/zsh

### Completion (before sourcing configs that register completions)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit

### Config
source $ZSH_CONFIG_DIR/config/alias.sh
source $ZSH_CONFIG_DIR/config/exports.sh
source $ZSH_CONFIG_DIR/config/scripts.sh
source $ZSH_CONFIG_DIR/config/worktree.sh

### Plugins
source $ZSH_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

### Prompt
eval "$(starship init zsh)"

### Tool completions
[ -s "/Users/martin-aleph/.bun/_bun" ] && source "/Users/martin-aleph/.bun/_bun"

### PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/Users/martin-aleph/.codeium/windsurf/bin:$PATH"
export PATH="/Users/martin-aleph/.local/bin:$PATH"
export PATH=/Users/martin-aleph/.opencode/bin:$PATH

export PNPM_HOME="/Users/martin-aleph/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

### Environment
export LOCALHOST_KEY="$HOME/.certs/localhost-key.pem"
export LOCALHOST_CERT="$HOME/.certs/localhost.pem"

eval "$(fnm env --shell=zsh --use-on-cd)"
