#!/usr/bin/env bash

# https://unix.stackexchange.com/questions/46081/identifying-the-system-package-manager

export aurhelper=paru
export package_manager=""

if [ -x "$(command -v pacman)" ]; then package_manager="pacman"
elif [ -x "$(command -v apt-get)" ]; then package_manager="apt-get"; fi

install_aur_helper() {
    # needs base-devel to be installed
    cd /tmp
    git clone https://aur.archlinux.org/$aurhelper
    cd $aurhelper
    makepkg --noconfirm -si 
}

update_system() {
  if [ $package_manager=="pacman" ]; then 
    # echo -e '[options]\nColor\nParallelDownloads = 12\n[multilib]\nInclude = /etc/pacman.d/mirrorlist' | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy && sudo pacman -S --noconfirm --needed base-devel git
  elif [ $package_manager=="apt-get" ]; then
    # apt-get not tested
    sudo apt update && sudo apt upgrade && sudo apt install build-essential git -y
  fi
}

install_packages() {
  local packages_dir="https://raw.githubusercontent.com/martinsione/dotfiles/master/install/packages"
  if [[ $package_manager == "pacman" ]]; then
    [ ! -x $(command -v "$aurhelper") ] && install_aur_helper
    sudo pacman -S --noconfirm --needed $(comm -12 <(pacman -Slq | sort) <(sort | curl "${packages_dir}/arch/pac.list" ))
    # yes | sudo -u $(whoami) $aurhelper -S libxft-bgra-git >/dev/null 2>&1 # otherwise it doesn't install due to conflicts
    ${aurhelper} -S --noconfirm --needed $(comm -12 <(${aurhelper} -Slq | sort) <(sort | curl "${packages_dir}/arch/aur.list" ))
  fi
}


add_echo_cancelation() {
sudo tee -a /etc/pulse/default.pa > /dev/null <<EOT
load-module module-echo-cancel aec_method=webrtc source_name=noechosource sink_name=noechosink
set-default-source noechosource
set-default-sink noechosink
EOT
}

mount_drive() {
  read -p "Do you want to mount disk to /mnt/s (y/n): " -n 1 -r
  echo -e '\n'
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo mkdir -p /mnt/s
    echo 'UUID=0492de4e-821d-48d4-970f-7a7ccb869fe0 /mnt/s ext4 rw,relatime 0 2' | sudo tee -a /etc/fstab
    echo -e 'Mounted drive correctly.\n' 
  fi
}

update_system
install_packages
add_echo_cancelation
mount_drive
