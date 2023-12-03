#!/bin/bash
#ejecutar usuario normal $sh 3.config.sh

function servidorGrafico {
    echo "INSTALAMOS SERVIDOR GRAFICO (XORG)"
    sudo pacman -S xorg xorg-server xorg-xinit --noconfirm
    echo "preparamos el archivo de configuracion"
    #sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
    echo " "
}

function windowsManager {
    #PAQUETES EXTRAS
    sudo pacman -S acpi --noconfirm #estado de la bateria
    sudo pacman -S community/acpilight --noconfirm #brillo de apntalla
    sudo pacman -S community/awesome-terminal-fonts --noconfirm #baterria
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
    #sudo cp /etc/i3blocks.conf /home/jkazuo55/.config/i3/
    sudo pacman -S rofi --noconfirm #menu de apps
    #config rofi
    git clone "https://github.com/jkazuo55/dotfiles.git"
    cp -r dotfiles/rofi ~/.config/
    rm -rf dotfiles
    
    echo "################################"
    echo "################################"
    echo "################################"
    echo "################################"
    echo "################################"
    
    
    yay -S aur/dunst-git --noconfirm #notificador
    sudo pacman -S libnotify --noconfirm #notify-send "ejemplo"
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

function dunst {
    sudo pacman -S libnotify dunst --noconfirm
    systemctl --user import-environment DISPLAY
    systemctl status --user dunst
    systemctl start --user dunst
    systemctl enable --user dunst
    #iconos notificaciones
    yay -S aur/paper-icon-theme-git --noconfirm
    
    git clone "https://github.com/jkazuo55/dotfiles.git"
    sudo cp -r dotfiles/dunst/dunstrc ~/.config/
    rm -rf dotfiles
}
