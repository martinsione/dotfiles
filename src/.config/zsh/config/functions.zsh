################################################################################
## Change cursor shape for different vi modes. Thanks @lukesmith
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
## Toggle fg and bg with CTRL-Z
################################################################################
function extract {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
        case "${n%,}" in
          *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
            tar xvf "$n"       ;;
          *.lzma)      unlzma ./"$n"      ;;
          *.bz2)       bunzip2 ./"$n"     ;;
          *.cbr|*.rar)       unrar x -ad ./"$n" ;;
          *.gz)        gunzip ./"$n"      ;;
          *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
          *.z)         uncompress ./"$n"  ;;
          *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
            7z x ./"$n"        ;;
          *.xz)        unxz ./"$n"        ;;
          *.exe)       cabextract ./"$n"  ;;
          *.cpio)      cpio -id < ./"$n"  ;;
          *.cba|*.ace)      unace x ./"$n"      ;;
          *)
            echo "extract: '$n' - unknown archive method"
            return 1
            ;;
        esac
      else
        echo "'$n' - file does not exist"
        return 1
      fi
    done
    fi
}

################################################################################
## Auto startx if tty = /dev/tty1
################################################################################
function auto-startx() {
  if pacman -Qs libxft-bgra >/dev/null 2>&1; then
    [ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx $XINITRC >/dev/null 2>&1
  else
    echo "Please install libxft-bgra-git from the aur"
  fi
}

################################################################################
## Auto start tmux if not in tmux
################################################################################
function auto-tmux() {
  [ -z "${TMUX}" ] && tmux new -As0

  ## This one gives problem when opening a term inside vim
  # [ -z "${TMUX}" ] && tmux attach || tmux new
}


################################################################################
## Auto start tmux if not in tmux
################################################################################
function install_nerd_fonts() {
    local install() {
        curl -L --create-dirs "${download_path}" -o "${font_path}.zip"
        unzip "${font_path}.zip" -d "${font_path}"
        rm -rf "${font_path}.zip" 
    }

    for font in "$@"
    do
        local font_path="$HOME/.local/share/fonts/${font}"
        local download_path="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${font}.zip"
        [ ! -d "${font_path}" ] && echo "Installing ${font} font." && install >/dev/null 2>&1 && echo "Done." || echo "${font} is already on your system"
    done
}
