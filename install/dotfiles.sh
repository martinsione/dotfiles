#!/bin/sh

export aurhelper=paru

get_mail() {
	mail1=$(dialog --inputbox "Enter your email." 10 60 3>&1 1>&2 2>&3 3>&1)
	mail2=$(dialog --inputbox "Retype your email." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$mail1" = "$mail2" ]; do
		unset mail2
		mail1=$(dialog --inputbox "Mails do not match.\\n\\nEnter your email again." 10 60 3>&1 1>&2 2>&3 3>&1)
		mail2=$(dialog --inputbox "Retype your email." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
  export email=$mail1 ;}

install_aur_helper() {
  cd /tmp
  git clone https://aur.archlinux.org/$aurhelper
  cd $aurhelper
  makepkg --noconfirm -si
  cd ~ ;}

# Clone dotfiles repo
sudo pacman -S --noconfirm git --needed base-devel
git clone https://github.com/martinsione/dotfiles.git ~/dotfiles

# Install packages
install_aur_helper
sudo pacman -S --noconfirm --needed $(comm -12 <(pacman -Slq | sort) <(sort ~/dotfiles/backup/arch/pac.list ))
echo -e '\n\nY\nY\n' | $aurhelper -S libxft-bgra-git
${aurhelper} -S --noconfirm --needed $(comm -12 <(${aurhelper} -Slq | sort) <(sort ~/dotfiles/backup/arch/aur.list ))

mkdir -p ~/.config/VSCodium/User ~/.local/share
cd ~/dotfiles
stow src

# Compile packages
cd ~/.local/src/dwm && make && sudo make clean install
cd ~/.local/src/dwmblocks && make && sudo make clean install
cd ~

# Change shell to zsh
chsh -s $(which zsh)

# Install ohmyzsh
echo -e "\n" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm -rf ~/.zshrc
mv ~/.oh-my-zsh ~/.local/share/oh-my-zsh

# Auto mount the hard drive
# echo 'UUID=0492de4e-821d-48d4-970f-7a7ccb869fe0	/mnt/storage	ext4		rw,relatime	0 2' | sudo tee -a /etc/fstab
echo 'export ZDOTDIR=$HOME/.config/zsh' | sudo tee -a /etc/zsh/zshenv

# Generate ssh keys
# ssh-keygen -t rsa -b 4096 -C "${email}"
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_rsa
