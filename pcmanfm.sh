#!/bin/bash

#listar iconos y temas
#ls /usr/share/icons/
#ls /usr/share/themes/
echo "instalar iconos"
#sudo pacman -S papirus-icon-theme 
yay -S flat-remix
echo "instalar themas"
yay -S flat-remix-gtk
#yay -S numix-gtk-theme-git
#echo "modificar Papirus-Dark y Numix"
echo "Flat-Remix-Red-Dark Flat-Remix-GTK-Blue-D
arkest"

sudo vim /usr/share/gtk-3.0/settings.ini
sudo vim /usr/share/gtk-2.0/gtkrc
echo "terminado"

