#!/bin/bash
#ejecutar usuario normal $sh 3.config.sh

function windowsManager {
    sudo pacman -S rofi --noconfirm #menu de apps
    sudo pacman -S blueberry --noconfirm #menu de apps
    sudo pacman -S nitrogen --noconfirm #generador de fondo de pantalla
    sudo pacman -S awesome-terminal-fonts --noconfirm #icons
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
