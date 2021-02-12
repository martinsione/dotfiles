#!/bin/bash

pacman -Sy --noconfirm dialog || { echo "Error at script start: Are you sure you're running this as the root user? Are you sure you have an internet connection?"; exit; }

dialog --defaultno --title "Welcome to Martin's Arch automated installation" --yesno "This is intended for personal use.\n\nTo stop this script, press no."  10 60 || exit

dialog --no-cancel --inputbox "Enter a name for your computer." 10 60 2> hostname

dialog --no-cancel --inputbox "Enter the disk in which you want to install the system." 10 60 2> disk.tmp

disk=$(cat mnt/etc/disk.tmp)

timedatectl set-ntp true

cat <<EOF | fdisk /dev/$disk
g
n


+550M
n



t
1
1
w
EOF
partprobe

mkfs.fat -F32 /dev/${disk}1 # Make first partition (+550M) f32
mkfs.ext4 /dev/${disk}2     # Make the second partition(left space on the drive) ext4
mount /dev/${disk}2 /mnt    # Mount the big partition

pacstrap /mnt base base-devel linux-lts linux-firmware

genfstab -U /mnt >> /mnt/etc/fstab    # Generate filesystem table
arch-chroot /mnt                      # Change to root of the installation

ln -sf /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime
hwclock --systohc

ln -sf /usr/share/zoneinfo/$TZuser /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Hostname and passwd
mv hostname /mnt/etc
hostname=$(cat mnt/etc/hostname)
cat >> /etc/hosts <<EOF
127.0.0.1       localhost
::1             localhost
127.0.1.1       ${hostname}.localdomain     ${hostname}
EOF

passwd

# Grub config for uefi
pacman -S --noconfirm grub efibootmgr dosfstoolgs os-prober mtools
mkdir /boot/EFI
mount /dev/${disk}1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# NetworkManager
pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl start NetworkManager

clear
