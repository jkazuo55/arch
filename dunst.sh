
sudo pacman -S libnotify dunst
systemctl --user import-environment DISPLAY
systemctl status --user dunst
systemctl start --user dunst
systemctl enable --user dunst


#iconos notificaciones
yay paper-icon-theme-git


