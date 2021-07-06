#!/usr/bin/env bash

set -e

export repo_host="https://github.com"
export repo_path="/martinsione/dotfiles"
export repo_branch="master"
export dotfiles_dir="$HOME/.dotfiles"
export symlinks_file="${dotfiles_dir}/links.conf"

symlinks=(
  .config/alacritty
  .config/kitty
  .config/nvim
  .config/tmux
  .config/zsh
  .zprofile
)


clone_repo() {
  if [ -d "$HOME/dotfiles" ]; then
    mv "$HOME/dotfiles" "${dotfiles_dir}";
  elif [ ! -d "${dotfiles_dir}" ]
    git clone "${repo_host}${repo_path}" "${dotfiles_dir}"
  fi

  if [ -d "${dotfiles_dir}" ]; then 
    cd ${dotfiles_dir} && git submodule update --init --recursive
  fi
}

symlink_files() {
  # arr=(); arr=("${arr[@]}" "sudo ln -s $HOME/blabla /usr/bin/blabla")
  # readarray -t links < $(awk -F ":" '!/^ *#/ && NF {print "ln -sr $HOME/.dotfiles/" $2 " $HOME/" $NF}' "${symlinks_file}")
  # readarray -t links < "${symlinks_file}"

  # for file in "${links[@]}",; do 
  #   eval "${file}" >/dev/null 2>&1
  # done

  for name in "${symlinks[@]}"; do
    if [ ! -e "$name" ]; then
      ln -srfv "${dotfiles_dir}/src/${name}" "$HOME/${name}"
    else
      echo "${name} already exists."
    fi
  done
}

# install_packages() {
#   # https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#List_of_installed_packages
# }

change_shell() {
  sudo chsh -s /usr/bin/zsh "${USER}" >/dev/null 2>&1
}


## Start of the script
clone_repo
symlink_files
change_shell
