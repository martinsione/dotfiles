# Path to your oh-my-zsh installation.
export ZSH="$HOME/.local/share/oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files as dirty
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(vi-mode)

source $ZSH/oh-my-zsh.sh

# Source all files under custom/
for file (~/.config/zsh/custom/**/**) source $file
