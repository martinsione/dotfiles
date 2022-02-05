#!/bin/bash

get_user_input() {
	name=$(dialog --no-cancel --inputbox "Enter the hostname of the computer." 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1
	while ! echo "$name" | grep -q "^[a-z_][a-z0-9_-]*$"; do
		name=$(dialog --no-cancel --inputbox "Hostname not valid. Give a hostname beginning with a letter, with only lowercase letters, - or _." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	pass1=$(dialog --no-cancel --passwordbox "Enter a password for that user." 10 60 3>&1 1>&2 2>&3 3>&1)
	pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	while ! [ "$pass1" = "$pass2" ]; do
		unset pass2
		pass1=$(dialog --no-cancel --passwordbox "Passwords do not match.\\n\\nEnter password again." 10 60 3>&1 1>&2 2>&3 3>&1)
		pass2=$(dialog --no-cancel --passwordbox "Retype password." 10 60 3>&1 1>&2 2>&3 3>&1)
	done
	disk=$(dialog --no-cancel --inputbox "Enter the disk in which you want to install the system" 10 60 3>&1 1>&2 2>&3 3>&1) || exit 1

  export hostname=$name; export passwd=$pass1; export disk=$disk;
}

# What happen with the disk
# cat <<EOF | fdisk /dev/${disk}
# g         | Set partition table to gpt
# n         | Creates a new partition
# Enter     | Enter
# Enter     | Enter
# +550M     | Select the size+550M
# n         | Creates a new partition
# Enter     | Enter
# Enter     | Enter
# Enter     | Enter => Uses all the space left
# t         | Change the tipe of the partition
# 1         | Of partition 1
# 1         | To tipe 1 (EFI System)
# w         | Write the changes
# EOF

# Start of the script
pacman -Sy --noconfirm dialog || { echo "Error at script start: Are you sure you're running this as the root user? Are you sure you have an internet connection?"; exit; }

dialog --defaultno --title "Welcome to Martin's Arch automated installation" --yesno "This is intended for personal use.\n\nTo stop this script, press no."  10 60 || exit

get_user_input

dialog --defaultno --title "Atencion" --yesno "Esta es la ultima opurtinidad de cancelar la instalacion.\n\nSi presionas si se borraran todos los datos de /dev/${disk}"  10 60 || exit

timedatectl set-ntp true

echo -e 'g\nn\n\n\n+550M\nn\n\n\n\nt\n1\n1\nw' | fdisk /dev/${disk}
mkfs.fat -F32 /dev/${disk}1 # Make first partition (+550M) f32
mkfs.ext4 /dev/${disk}2     # Make the second partition(left space on the drive) ext4

mount /dev/${disk}2 /mnt

pacstrap /mnt base linux-lts linux-firmware lsb-release --needed base-devel

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt                      # Change to root of the installation

# Select time zone
ln -sf /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime
# Set hardware clock
hwclock --systohc

# Set the locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Hostname and password
echo ${hostname} >> /etc/hostname
cat >> /etc/hosts <<-EOF
127.0.0.1       localhost
::1             localhost
127.0.1.1       ${hostname}.localdomain     ${hostname}
EOF
echo -e "${passwd}\n${passwd}" | passwd

# Grub cfg and NetworkManager
pacman -S --noconfirm grub efibootmgr dosfstools os-prober mtools networkmanager
mkdir /boot/EFI
mount /dev/${disk}1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl start NetworkManager
