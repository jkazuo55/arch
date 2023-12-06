#!/bin/bash
#ejecutar usuario normal $sh 3.config.sh

function preinstall {
    sudo pacman -S rofi --noconfirm #menu de apps
    yay -S aur/rofi-greenclip
    sudo pacman -S nitrogen --noconfirm #generador de fondo de pantalla
}


function bluetooth {
    sudo pacman -S bluez bluez-utils blueman
    sudo systemctl enable bluetooth.service
    sudo systemctl start bluetooth.service
    # exec --no-startup-id blueman-applet
}

function copyfiles {
    cp -r i3 /home/julhuarachi/.config
    cp -r rofi /home/julhuarachi/.config
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
