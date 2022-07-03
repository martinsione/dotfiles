## Create ssh keys

```sh
ssh-keygen -t rsa -b 4096 -C "name@mail.com"
sudo systemctl restart ssh

# Linux
xclip -sel clip < ~/.ssh/id_rsa.pub

# MacOS
cat ~/.ssh/id_rsa.pub | pbcopy

# WSL
clip.exe  < ~/.ssh/id_rsa.pub
```

## Create a user

```sh
useradd -mg wheel martin
passwd martin
# echo '%wheel ALL=(ALL) ALL'
```

## Setup notion api keys in $HOME/.config/zsh/config/.env

```sh
export NOTION_API_KEY="<api-key>"
export NOTION_DATABASE_ID="<database-id>"
```

## Neovim dependencies

```sh
sudo apt-get install libtool libtool-bin autoconf automake cmake libncurses5-dev g++
```

## Gnome base install

```sh
firefox
gdm
gnome-shell
gnome-control-center
```

## Workaround for redshift

```sh
redshift-gtk -l -34.6:-58.3 & disown
```

## Get qemu/virt-manager to work

```sh
sudo pacman -Syu ebtables dnsmasq
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
```

## Gdrive with rclone

```sh
rclone config
sudo mkdir /mnt/gdrive
sudo chmod 775 o 777 /mnt/gdrive
rclone mount --daemon gdrive: /mnt/gdrive
# To unmount: fusermount -uz /path/to/drive
```
