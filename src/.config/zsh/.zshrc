# https://github.com/akinsho/dotfiles/blob/main/zsh/.zshrc
# https://github.com/wincent/wincent/blob/master/aspects/dotfiles/files/.zshrc
# NOTE: -z returns true if a string value has a length of 0

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __MARTIN
__MARTIN[ITALIC_ON]=$'\e[3m'
__MARTIN[ITALIC_OFF]=$'\e[23m'

## Load ZSH VARS
export ZSH=$HOME/.config/zsh
export ZSH_CONFIG=$ZSH/config
export ZSH_CACHE=$HOME/.cache/zsh
export ZSH_ALIAS=$ZSH_CONFIG/alias
export ZSH_PLUGIN=$ZSH/plugins


## Source config files
[ -f $ZSH_CONFIG/exports.zsh ] && source $ZSH_CONFIG/exports.zsh
[ -f $ZSH_CONFIG/completion.zsh ] && source $ZSH_CONFIG/completion.zsh
[ -f $ZSH_CONFIG/keymaps.zsh ] && source $ZSH_CONFIG/keymaps.zsh
[ -f $ZSH_CONFIG/options.zsh ] && source $ZSH_CONFIG/options.zsh
[ -f $ZSH_CONFIG/functions.zsh ] && source $ZSH_CONFIG/functions.zsh
[ -d $ZSH_ALIAS ] && for file ($ZSH_ALIAS/*.zsh) source $file

## Load compinit
autoload -U compinit

## Plugins
source $ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGIN/zsh-autosuggestions/zsh-autosuggestions.zsh

## Set zcompdump file path
ZSH_COMPDUMP="$ZSH_CACHE/zcompdump-${ZSH_VERSION}"
compinit -u -C -d "${ZSH_COMPDUMP}"

## Load Prompt
eval "$(starship init zsh)"

remap
