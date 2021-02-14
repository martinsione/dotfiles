#!/bin/sh

get_user_and_pass() {
	name=$(dialog --inputbox "First, please enter a name for the user account." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		name=$(dialog --no-cancel --inputbox "Username not valid. Give a username beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	done ;}

adduserandpass() {
	useradd -mg wheel "$name" >/dev/null 2>&1
	usermod -aG wheel "$name"
	echo "$name:$pass1" | chpasswd
	unset pass1 pass2 ;}

pacman -Sy --noconfirm dialog || { echo "Error at script start: Are you sure you're running this as the root user? Are you sure you have an internet connection?"; exit; }
get_user_and_pass
adduserandpass
pacman -S --noconfirm sudo
echo "$name  ALL=(ALL:ALL) ALL" >> /etc/sudoers
su -l $name
dialog --defaultno --title "Welcome to Martin's Arch automated installation" --yesno "Do you want to install Martin's dotfiles?"  10 60 || exit

install_path=https://raw.githubusercontent.com/martinsione/dotfiles/testing/install
curl ${install_path}/dotfiles.sh | bash
