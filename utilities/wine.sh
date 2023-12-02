sudo pacman -S wine wine-mono wine_gecko
sudo pacman -S --asdeps $(pactree -l wine)
sudo pacman -S winetricks playonlinux
