#!/bin/bash

 function yay {
    echo "instalando yay"
    git clone "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si
    cd ..
    rm -r yay
 }
 function sistema {
    #UPDATE
    echo "ACTUALIZAMOS SISTEMA"
    sudo pacman -Syyyu --noconfirm
    echo ""
 }

 function servidorGrafico {
    #SERVIDOR GRAFICO
    echo "INSTALAMOS SERVIDOR GRAFICO (XORG)"
    # sudo pacman -S xorg xorg-server xorg-xinit 
    sudo pacman -S xorg-server xorg-xinit --noconfirm
    echo "preparamos el archivo de configuracion"
    sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
    echo ""
 }

  function sessionManager {
    #SESSION MANAGER
    echo "INSTALAMOS SESSION MANAGER (SLIM) "
    sudo pacman -S slim slim-themes archlinux-themes-slim --noconfirm
    sudo systemctl enable slim.service
    echo ""
  }

  function windowsManager {
    #PAQUETES EXTRAS
    sudo pacman -S acpi --noconfirm #estado de la bateria
    sudo pacman -S neofetch --noconfirm #informacion del sistema
    sudo pacman -S feh --noconfirm #visor de imagenes
    sudo pacman -S playerctl --noconfirm #mostrar cancion actual
    sudo pacman -S sysstat --noconfirm #estado del sistema
    sudo pacman -S lm_sensors --noconfirm #monitoreo de hardware
    sudo pacman -S xsensors --noconfirm #monitoreo de sensores
    sudo pacman -S noto-fonts-emoji --noconfirm #funtes de google
    #WINDOW MANAGER
    echo "INSTALAMOS WINDOW MANAGER (I3-gaps)"
    sudo pacman -S i3-gaps --noconfirm  #fork de i3
    sudo pacman -S i3blocks --noconfirm #estado de monitoreo para panel
    sudo cp /etc/i3blocks.conf /home/jkazuo55/.config/i3/ 
    sudo pacman -S rofi --noconfirm #menu de apps
    
    yay -S aur/dunst-git --noconfirm #notificador
    systemctl --user import-environment DISPLAY
    systemctl start --user dunst
    systemctl enable --user dunst
    
    sudo pacman -S nitrogen --noconfirm #generador de fondo de pantalla
    echo "configuramos el incio automatico de i3-gaps"
    echo "exec i3" > /home/jkazuo55/.xinitrc

    #CONFIGURACION I3
    git clone "https://github.com/jkazuo55/i3.git" /home/jkazuo55/.config/i3/
    #CONFIGURACION I3BLOCKS
  }
  
yay
sistema
servidorGrafico
sessionManager
windowsManager
