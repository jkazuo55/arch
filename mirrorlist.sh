#!/bin/bash

yay -S mirrorlist-rankmirrors-hook --noconfirm
echo "descargamos los mirrors"
curl -o mirrorlist https://www.archlinux.org/mirrorlist/all/
echo "filtramos los mirrors"
sed -i 's/#S/S/g' mirrorlist
echo "Buscando los 10 mejores servidores....."
rankmirrors mirrorlist > mirrorlist.fastest

sudo rm /etc/pacman.d/mirrorlist
sudo mv mirrorlist.fastest /etc/pacman.d/mirrorlist

echo "eliminando basura"
sudo rm mirrorlist



