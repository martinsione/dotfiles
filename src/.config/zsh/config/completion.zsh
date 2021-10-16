WORDCHARS=''

zstyle ':completion:*:*:*:*:*' menu select                      # Select menu
zstyle ':completion:*' special-dirs false                       # Complete . and .. special directories
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_CACHE

# Same colors as ls
eval "$(dircolors)"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{yellow}%B%{$__MARTIN[ITALIC_ON]%}--- %d ---%{$__MARTIN[ITALIC_OFF]%}%b%f

# # disable named-directories autocompletion
# zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# # $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# # to dominate completion; exclude path-directories from the tag-order so that
# # they will only be used as a fallback if no completions are found.
# zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'
