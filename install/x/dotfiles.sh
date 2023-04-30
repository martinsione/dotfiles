#!/usr/bin/env bash

# Script name: dotfiles
# Description: Script to deploy my dotfiles easily.
# Dependencies: git, curl, zsh

export repo_host="https://github.com/"
export repo_path="martinsione/dotfiles.git"
export dotfiles_dir="$HOME/.dotfiles"

dirs=(
  ~/.cache/zsh
  ~/.config
  ~/.local
  ~/Repos
)

symlinks=(
  .config/git
  .config/htop
  .config/kitty
  .config/nvim
  .config/ranger
  .config/tmux
  .config/zsh
  # .local/bin
  .zshrc
)

## End of configuration
set -e

install_dependencies() {
  local progs="git curl zsh"
  if [ "$(uname)" = "Darwin" ]; then
    echo "Skipping installation of dependencies on macOS"
  elif [ -x "$(command -v pacman)" ]; then 
    sudo pacman -Syy && sudo pacman -S --noconfirm $progs
  elif [ -x "$(command -v apt-get)" ]; then 
    sudo apt update && sudo apt install -y $progs
  fi
}

clone_repo() {
  if [ -d "$HOME/dotfiles" ]; then
    mv "$HOME/dotfiles" "${dotfiles_dir}";
  elif [ ! -d "${dotfiles_dir}" ]; then
    git clone "${repo_host}/${repo_path}" "${dotfiles_dir}"
  fi

  if [ -d "${dotfiles_dir}" ]; then 
    cd ${dotfiles_dir} && git submodule update --init --recursive
    ## Change to ssh url
    git remote set-url origin git@github.com:${repo_path}
  fi
}

create_dirs() {
  for name in "${dirs[@]}"; do mkdir -p "${name}"; done
}

symlink_files() {
  for name in "${symlinks[@]}"; do
    if [ ! -e "$name" ]; then
      ln -sfv "${dotfiles_dir}/src/${name}" "$HOME/${name}"
    else
      echo "${name} already exists."
    fi
  done
}

change_shell() {
  if [ "$(echo $SHELL)" = "$(which zsh)" ]; then
    echo "zsh is already the default shell"
  else
    chsh -s $(which zsh)
  fi

  if [ -x "$(command -v starship)" ]; then
    echo "starship is already installed"
  elif [ -x "$(command -v brew)" ]; then
    brew install starship
  else
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  fi
}


## Start of the script
install_dependencies
clone_repo
create_dirs
symlink_files
change_shell
