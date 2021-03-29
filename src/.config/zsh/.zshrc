export ZSH_DIR=$HOME/.config/zsh/
export ALIAS_DIR=$ZSH_DIR/custom/alias/
export LIB_DIR=$ZSH_DIR/custom/lib/
export SCRIPTS_DIR=$ZSH_DIR/custom/scripts/
export PLUGINS_DIR=$ZSH_DIR/custom/plugins/

[ -f $ZSH_DIR ] && source source $ZSH_DIR/custom/export.zsh
[ -d $ALIAS_DIR ] && for file ($ALIAS_DIR/*) source $file
[ -d $LIB_DIR ] && for file ($LIB_DIR/*) source $file
[ -d $SCRIPTS_DIR ] && for file ($SCRIPTS_DIR/*) source $file
[ -d $PLUGINS_DIR ] && for file ($PLUGINS_DIR/*) source $file

autoload -U colors && colors	# Load colors
unsetopt BEEP
unsetopt PROMPT_SP

# Load Prompt
eval "$(starship init zsh)"

# Load Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
