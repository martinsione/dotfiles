## Create a user
useradd -mg wheel martin
passwd martin
# echo '%wheel ALL=(ALL) ALL' 

## gnome base install
firefox 
gdm 
gnome-shell 
gnome-control-center

## Workaround for redshift
redshift-gtk -l -34.6:-58.3 & disown

## Get qemu/virt-manager to work
sudo pacman -Syu ebtables dnsmasq
sudo systemctl enable libvirtd
sudo systemctl start libvirtd

## Gdrive with rclone
rclone config
sudo mkdir /mnt/gdrive
sudo chmod 775 o 777 /mnt/gdrive
rclone mount --daemon gdrive: /mnt/gdrive
**To unmount:** fusermount -uz /path/to/drive

## Create ssh keys
ssh-keygen -t rsa -b 4096 -C "name@mail.com"
sudo systemctl restart ssh

xclip -sel clip < ~/.ssh/id_rsa.pub (linux) 
clip.exe  < ~/.ssh/id_rsa (wsl)
