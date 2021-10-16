## Completion
unsetopt menu_complete                                          # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu                                                # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

## Directory
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt auto_param_slash                                         # tab completing directory appends a slash

## General
unsetopt beep                                                   # Disable bell
unsetopt prompt_sp                                              # https://superuser.com/questions/645599/why-is-a-percent-sign-appearing-before-each-prompt-on-zsh-in-windows

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.cache/zsh/history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
## History command configuration
setopt extended_history                                         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first                                   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups                                         # ignore duplicated commands history list
setopt hist_ignore_space                                        # ignore commands that start with space
setopt hist_verify                                              # show command with history expansion to user before running it
setopt share_history                                            # share command history data

##
# setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
# setopt numericglobsort                                          # Sort filenames numerically when it makes sense
# setopt nobeep                                                   # No beep
# setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
