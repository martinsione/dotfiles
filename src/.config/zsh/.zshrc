ZSH_CONFIG_DIR=$HOME/.config/zsh

source $ZSH_CONFIG_DIR/config/alias.sh
source $ZSH_CONFIG_DIR/config/exports.sh
source $ZSH_CONFIG_DIR/config/scripts.sh

## Plugins
source $ZSH_CONFIG_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CONFIG_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

### Load Prompt
eval "$(starship init zsh)"

### Completion
# Enable case-insensitive path completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Make completion menu selection visible
zstyle ':completion:*' menu select
# Initialize completion system
autoload -Uz compinit && compinit
