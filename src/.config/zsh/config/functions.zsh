################################################################################
## Change cursor shape for different vi modes. Thanks @lukesmith               #
################################################################################
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

################################################################################
## Toggle fg and bg with CTRL-Z
################################################################################
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg


################################################################################
# Auto startx if tty = /dev/tty1                                               #
################################################################################
function auto-startx() {
  if pacman -Qs libxft-bgra >/dev/null 2>&1; then
    [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx $XINITRC
  else
    echo "\033[31mIMPORTANT\033[0m: Note that \033[32m\`libxft-bgra\`\033[0m must be installed for this build of dwm.
  Please run:
    \033[32mparu -S libxft-bgra-git\033[0m
  and replace \`libxft\`. Afterwards, you may start the graphical server by running \`startx\`."
  fi
}
