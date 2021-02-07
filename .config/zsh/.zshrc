#----------------------------- ZSH config ------------------------------
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/exports" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/exports"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/cursor" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/cursor"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/icons" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/icons"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/alias" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/alias"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bm-dirs" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bm-dirs"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bm-files" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/bm-files"

#------------------ History in chache directory ------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Options section
setopt appendhistory                                        # Immediately append history instead of overwriting
setopt autocd                                               # if only directory path is entered, cd there.
setopt correct                                              # Auto correct mistakes
setopt globdots                                             # Show hidden files
setopt nobeep                                               # No beep

# Use vim keys in tab complete menu:
zmodload zsh/complist                                       # To have vim keybindings on menu select
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v                                                  # Vi mode
export KEYTIMEOUT=1                                         # Reduce vi timeout

# Completions
zstyle ':completion:*' menu select                          # Menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive tab completion
zstyle ':completion:*' rehash true                          # automatically find new executables in path
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
# Fix tab completion colors
if [[ -z "$LS_COLORS" ]]; then
 (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
autoload -U colors compinit promptinit zcalc
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
# colors

#------------------------ Change Caps to Escape ------------------------
sudo -n loadkeys $HOME/.local/bin/ttymaps.kmap 2>/dev/null

#-------------------------- Load Plugins -------------------------------
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
