## Programs
alias r="$FILE"
alias sr="sudo $FILE"
alias v="$EDITOR"
alias sv="sudo $EDITOR"
alias code="$GEDITOR"
## Color
alias diff="diff --color=auto"
alias grep="grep --color=auto"
## File manipulation
alias mkd="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias rmln="find . -xtype l -delete"
## Listing
alias l="exa -l --group-directories-first"
alias ll="exa -la --group-directories-first"
alias ls="exa --icons -a --group-directories-first"
## System
alias bld="make && sudo make install"
alias cl="clear"
alias ka="killall"
alias ex="extract"
alias startx="startx $XINITRC"

## Packages
alias vst="nvim --startuptime test.tmp -c :q && nvim test.tmp && rm -rf test.tmp"
alias vupg="cd ~/.local/src/neovim && git pull && make && sudo make install && cd -"
if [[ $DISTRO == "Arch" ]]; then
  alias p="sudo pacman"
  alias paru="paru --bottomup"
  alias upg="paru -Syu --noconfirm"
  alias cleanup="sudo pacman -Rns $(pacman -Qtdq)"
elif [[ $DISTRO == "Ubuntu" ]]; then
  alias upg="sudo apt update && sudo apt upgrade && sudo snap refresh --list"
fi

## Git
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gcb="git checkout -b"
alias gco="git checkout"
alias gc!="git commit -v --amend"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gd="git diff"
alias gcl="git clone"
alias gcu="git reset --soft HEAD~1"
alias glg="git lg"
alias gp='git push'
alias gP='git pull'
alias gr='git remote'
alias gm='git merge'
alias gs="git st"
alias gst="git status"

## Tmux
alias t="tmux -u"
alias ta="tmux -u a"
alias tls="tmux ls"
alias tks="tmux kill-session -t"

## Directories
alias d="$HOME/dotfiles"
alias D="$HOME/Downloads"
alias P="$HOME/Pictures"
alias W="$HOME/Workspace"
alias sc="$HOME/.local/bin"
alias sb="$HOME/.local/bin/statusbar"
alias src="$HOME/.local/src"
alias sto="/mnt/storage"
alias cs="/mnt/storage/Martin/Study/Courses/"
alias fc="/mnt/storage/Martin/Study/Facu"
alias fc1="/mnt/storage/Martin/Study/Facu/Cuatrimestres/1"
alias fcp="/mnt/storage/Martin/Study/Facu/Cuatrimestres/1/FuPro/Ejercicios/Cpp"
