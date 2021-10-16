## Change cursor shape for different vi modes. Thanks @lukesmith
function cursor-shape() {
  function zle-keymap-select() {
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
}

## Toggle fg and bg with CTRL-Z
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg


## Uncompress files
function extract() {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in "$@"; do
      if [ -f "$n" ] ; then
        case "${n%,}" in
          *.tar.bz2)   tar xjf "$n"     ;;
          *.tar.gz)    tar xzf "$n"     ;;
          *.bz2)       bunzip2 "$n"     ;;
          *.rar)       unrar x "$n"     ;;
          *.gz)        gunzip "$n"      ;;
          *.tar)       tar xf "$n"      ;;
          *.tbz2)      tar xjf "$n"     ;;
          *.tgz)       tar xzf "$n"     ;;
          *.zip)       unzip "$n"       ;;
          *.Z)         uncompress "$n"  ;;
          *.7z)        7z x "$n"        ;;
          *)           echo "extract: '$n' - unknown archive method" ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
    fi
}

## Auto startx if tty = /dev/tty1
function auto-startx() {
  if pacman -Qs libxft-bgra >/dev/null 2>&1; then
    [ "$(tty)" = "/dev/tty1" ] && (! pidof -s Xorg && exec startx $XINITRC) >/dev/null 2>&1
  else
    echo "Please install libxft-bgra-git from the aur"
  fi
}

function zathura-tabbed() {
  (tabbed -c zathura "$@" -e & disown) >/dev/null 2>&1
}

## Usb burn helper
burn() {
  if [ -z "$2" ]; then
    echo "Usage: burn <path/iso> <path/to/flashdrive>"
  else
    sudo dd bs=4M if="$1" of="$2" status=progress && sync
  fi
}
