#!/bin/sh

export aurhelper=paru
export github="https://github.com"
export github_text="https://raw.githubusercontent.com"
export repo_path="martinsione/dotfiles"
export repo_branch="master"
export DISTRO="$(lsb_release -is)"

install_aur_helper() {
    cd /tmp
    git clone https://aur.archlinux.org/$aurhelper
    cd $aurhelper
    makepkg --noconfirm -si 
}

update_system() {
    if [[ $DISTRO == "Arch" ]]; then
      sudo pacman -Sy && sudo pacman -S --noconfirm --needed base-devel git
      install_aur_helper
    elif [[ $DISTRO == "Ubuntu" || $DISTRO == "Pop" ]]; then
      sudo apt update && sudo apt upgrade
      sudo apt install git
    fi
}

install_packages() {
  local packages_dir="https://raw.githubusercontent.com/martinsione/dotfiles/master/install/packages"
  local packages_dir="${github_text}/${repo_path}/${repo_branch}/install/packages"
  if [[ $DISTRO == "Arch" ]]; then
    echo -e '[multilib]\nInclude = /etc/pacman.d/mirrorlist\n[options]\nColor' | sudo tee -a /etc/pacman.conf
    yes | sudo -u $(whoami) $aurhelper -S libxft-bgra-git >/dev/null 2>&1 # otherwise it doesn't install due to conflicts
    pacman -S --needed - < | curl "${packages_dir}/arch/pac.list"
    sudo pacman -S --noconfirm --needed $(comm -12 <(pacman -Slq | sort) <(sort | curl "${packages_dir}/arch/pac.list" ))
    ${aurhelper} -S --noconfirm --needed $(comm -12 <(${aurhelper} -Slq | sort) <(sort | curl "${packages_dir}/arch/aur.list" ))
  fi
}

install_nerd_fonts() {
  local install() {
    curl -L --create-dirs "${download_path}" -o "${font_path}.zip"
    unzip "${font_path}.zip" -d "${font_path}"
    rm -rf "${font_path}.zip" 
  }
  for font in "$@"
  do
    local font_path="$HOME/.local/share/fonts/${font}"
    local download_path="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/${font}.zip"
    [ ! -d "${font_path}" ] && install >/dev/null 2>&1 || echo "${font} is already on your system"
  done
}

add_echo_cancelation() {
  echo 'load-module module-echo-cancel aec_method=webrtc source_name=noechosource sink_name=noechosink' | sudo tee -a /etc/pulse/default.pa
  echo 'set-default-source noechosource' | sudo tee -a /etc/pulse/default.pa
  echo 'set-default-sink noechosink' | sudo tee -a /etc/pulse/default.pa
}


# Start of the script
update_system
install_packages

git clone --recursive https://github.com/martinsione/dotfiles.git ~/dotfiles

mkdir -p Downloads Documents Pictures Workspace ~/.config/Code/User ~/.local/share ~/.local/bin ~/.local/src ~/.cache/zsh
cd ~/dotfiles
stow src

# Compile packages
for file in ~/.local/src/*; do cd "$file" && make && sudo make install; done

add_echo_cancelation

# Create .pulse-cookie in /tmp
echo 'cookie-file = /tmp/pulse-cookie' | sudo tee -a /etc/pulse/client.conf

# Generate ssh keys
# ssh-keygen -t rsa -b 4096 -C "${email}"
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa

# Auto mount the hard drive
echo 'UUID=0492de4e-821d-48d4-970f-7a7ccb869fe0	/mnt/storage	ext4		rw,relatime	0 2' | sudo tee -a /etc/fstab

install_nerd_fonts FiraCode JetBrainsMono SourceCodePro

# Change shell to zsh
chsh -s $(which zsh)
