# Set encoding
export LANG=en_US.UTF-8

# Export Programs
export BROWSER="brave"
export EDITOR="nvim"
export FILE="ranger"
export GEDITOR="code"
export GFILE="pcmanfm"
export MAIL="thunderbird"
export READER="zathura"
export TERMINAL="kitty"
export DMENU="dmenu"
export DISTRO="$(lsb_release -is)"

# XDG paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_PICTURES_HOME="$HOME/Pictures"

## ~/ Clean-up:
## XDG_CONFIG_HOME
export INPUTRC="$XDG_CONFIG_HOME/zsh/inputrc"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
# export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
## XDG_DATA_HOME
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
## XDG_RUNTIMER_DIR
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"   # May break a login manager

## Path
PATH="$CARGO_HOME/bin:$PATH"
PATH="$XDG_BIN_HOME/:$PATH"
PATH="$XDG_BIN_HOME/dmenu:$PATH"
PATH="$XDG_BIN_HOME/npm/node_modules/.bin:$PATH"
PATH="$XDG_BIN_HOME/scripts:$PATH"
PATH="$XDG_BIN_HOME/statusbar:$PATH"

# Other program settings:
export AWT_TOOLKIT="MToolkit wmname LG3D"	  #May have to install wmname
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export KEYTIMEOUT=1 # Reduce vi timeout
export LESSHISTFILE=-                       # Disable hist files
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export MANPAGER="nvim -c 'set ft=man'"
export _JAVA_AWT_WM_NONREPARENTING=1        # Fix for Java applications in dwm

## NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

