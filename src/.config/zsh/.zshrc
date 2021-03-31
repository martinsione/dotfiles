export ZSH=$HOME/.config/zsh

[ -f $ZSH ] && source source $ZSH/custom/export.zsh
[ -d $ALIAS ] && for file ($ALIAS/*) source $file
[ -d $LIB ] && for file ($LIB/*) source $file
[ -d $SCRIPTS ] && for file ($SCRIPTS/*) source $file
[ -d $PLUGINS ] && for file ($PLUGINS/*) source $file

# autoload -U colors && colors	# Load colors
unsetopt BEEP
unsetopt PROMPT_SP

# Load Prompt
eval "$(starship init zsh)"

# Load Plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="~/.cache/zsh/zcompdump-$ZSH_VERSION"
fi

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

compinit -i -C -d "${ZSH_COMPDUMP}"


# # Add all defined plugins to fpath. This must be done
# before running compinit.
# for plugin ($plugins); do
#   if is_plugin $ZSH_CUSTOM $plugin; then
#     fpath=($ZSH_CUSTOM/plugins/$plugin $fpath)
#   elif is_plugin $ZSH $plugin; then
#     fpath=($ZSH/plugins/$plugin $fpath)
#   else
#     echo "[oh-my-zsh] plugin '$plugin' not found"
#   fi
# done


# for config_file ($ZSH/*/lib/*.zsh); do
#   custom_config_file="${ZSH_CUSTOM}/lib/${config_file:t}"
#   [ -f "${custom_config_file}" ] && config_file=${custom_config_file}
#   source $config_file
# done
