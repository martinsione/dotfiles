#!/bin/sh

export aurhelper=paru

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


# Start of the script
# get_mail_and_pass

# Clone dotfiles repo
sudo pacman -S --noconfirm --needed base-devel git
git clone https://github.com/martinsione/dotfiles.git ~/dotfiles

# Install packages
install_aur_helper
yes | sudo -u $(whoami) $aurhelper -S libxft-bgra-git >/dev/null 2>&1   # otherwise it doesn't install due to conflicts
sudo pacman -S --noconfirm --needed $(comm -12 <(pacman -Slq | sort) <(sort ~/dotfiles/backup/arch/pac.list ))
${aurhelper} -S --noconfirm --needed $(comm -12 <(${aurhelper} -Slq | sort) <(sort ~/dotfiles/backup/arch/aur.list ))

mkdir -p ~/.config/VSCodium/User ~/.local/share
cd ~/dotfiles
stow src

# Compile packages
for file in ~/.local/src/*; do cd "$file" && make && sudo make clean install; done
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
