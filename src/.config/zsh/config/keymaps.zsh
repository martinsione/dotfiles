# Vi mode
# bindkey -v
bindkey -e

bindkey '^[[Z' reverse-menu-complete              # [Shift-Tab] - move through the completion menu backwards

bindkey '^?' backward-delete-char                 # [Backspace] - delete backward
bindkey -M viins "^[[3~" delete-char              # [Delete]
bindkey -M vicmd "^[[3~" delete-char              # [Delete]

bindkey  "^[[H"   beginning-of-line               # [Home]
bindkey  "^[[F"   end-of-line                     # [End]

bindkey '^[[3;5~' kill-word                       # [Ctrl-Delete]
bindkey '^H' backward-kill-word                   # [Ctrl-Backspace]

bindkey '^[[1;5C' forward-word                    # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                   # [Ctrl-LeftArrow] - move backward one word

bindkey '^r' history-incremental-search-backward  # [Ctrl-r] - Search backward incrementally for a specified string.
bindkey ' ' magic-space                           # [Space] - expand command

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'      # [Ctrl-f] - Cd to selected file in fzf

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

# Select completion and display next
bindkey -M menuselect '^o' accept-and-infer-next-history
