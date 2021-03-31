ZSH=$HOME/.config/zsh
EXPORTS=$ZSH/config/export.zsh

# Source config files
[ -f $EXPORTS ] && source $EXPORTS
[ -d $ALIAS ] && for file ($ALIAS/*.zsh) source $file
[ -d $CONFIG ] && for file ($CONFIG/*.zsh) source $file
[ -d $SCRIPTS ] && for file ($SCRIPTS/*.zsh) source $file

# Disable bell
unsetopt BEEP
unsetopt PROMPT_SP

# Load compinit
autoload -U compinit

# Load plugins
source $PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGIN/zsh-autosuggestions/zsh-autosuggestions.zsh

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"
fi

compinit -u -C -d "${ZSH_COMPDUMP}"

# Load Prompt
eval "$(starship init zsh)"
