#!/bin/bash
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install snapd


######### DEVELOPMENT ########
sudo snap install code --classic
sudo snap install organize-my-files
sudo snap install spotify



###### CONFIGURACION ########
#ln -s /var/lib/snapd/desktop/applications/rubymine_rubymine.desktop .local/share/applications

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/snapd/desktop/"
