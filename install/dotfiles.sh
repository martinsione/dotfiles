#!/bin/sh

export aurhelper=paru
export DISTRO="$(lsb_release -is)"


get_mail_and_pass() {
    mail1=$(dialog --inputbox "Enter your email." 10 60 3>&1 1>&2 2>&3 3>&1)
    mail2=$(dialog --inputbox "Retype your email." 10 60 3>&1 1>&2 2>&3 3>&1)
    while ! [ "$mail1" = "$mail2" ]; do
        unset mail2
        mail1=$(dialog --inputbox "Mails do not match.\\n\\nEnter your email again." 10 60 3>&1 1>&2 2>&3 3>&1)
        mail2=$(dialog --inputbox "Retype your email." 10 60 3>&1 1>&2 2>&3 3>&1)
    done
    export email=$mail1; export pass=$pass1 ;}

install_aur_helper() {
    cd /tmp
    git clone https://aur.archlinux.org/$aurhelper
    cd $aurhelper
    makepkg --noconfirm -si ;}

update_system() {
    if [[ $DISTRO == "Arch" ]]; then
      echo -e '[multilib]\nInclude = /etc/pacman.d/mirrorlist' | sudo tee -a /etc/pacman.conf
      echo -e '[options]\nColor' | sudo tee -a /etc/pacman.conf
      sudo pacman -Sy && sudo pacman -S --noconfirm --needed base-devel git
      install_aur_helper

      # Install packages
      yes | sudo -u $(whoami) $aurhelper -S libxft-bgra-git >/dev/null 2>&1   # otherwise it doesn't install due to conflicts
      sudo pacman -S --noconfirm --needed $(comm -12 <(pacman -Slq | sort) <(sort | curl https://raw.githubusercontent.com/martinsione/dotfiles/master/install/packages/arch/pac.list ))
      ${aurhelper} -S --noconfirm --needed $(comm -12 <(${aurhelper} -Slq | sort) <(sort | curl https://raw.githubusercontent.com/martinsione/dotfiles/master/install/packages/arch/aur.list ))
    elif [[ $DISTRO == "Ubuntu" ]]; then
      sudo apt update && sudo apt upgrade
      sudo apt install git
    fi ;}

install_nerd_fonts() {
    for font in $@
    do
        curl -L --create-dirs https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$font.zip -o ~/.local/share/fonts/$font.zip
        unzip ~/.local/share/fonts/$font.zip -d ~/.local/share/fonts/$font
        rm -rf ~/.local/share/fonts/$font.zip
    done ;}


# Start of the script
update_system

git clone --recursive https://github.com/martinsione/dotfiles.git ~/dotfiles

mkdir -p Downloads Documents Pictures Workspace ~/.config/Code/User ~/.local/share ~/.local/bin ~/.local/src ~/.cache/zsh
cd ~/dotfiles
stow src

# Compile packages
for file in ~/.local/src/*; do cd "$file" && make && sudo make install; done

# Add echo cancelation
echo 'load-module module-echo-cancel aec_method=webrtc source_name=noechosource sink_name=noechosink' | sudo tee -a /etc/pulse/default.pa
echo 'set-default-source noechosource' | sudo tee -a /etc/pulse/default.pa
echo 'set-default-sink noechosink' | sudo tee -a /etc/pulse/default.pa

# Create .pulse-cookie in /tmp
echo 'cookie-file = /tmp/pulse-cookie' | sudo tee -a /etc/pulse/client.conf

# Generate ssh keys
# ssh-keygen -t rsa -b 4096 -C "${email}"
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa

# Auto mount the hard drive
# echo 'UUID=0492de4e-821d-48d4-970f-7a7ccb869fe0	/mnt/storage	ext4		rw,relatime	0 2' | sudo tee -a /etc/fstab

install_nerd_fonts FiraCode JetBrainsMono SourceCodePro

# Change shell to zsh
chsh -s $(which zsh)
