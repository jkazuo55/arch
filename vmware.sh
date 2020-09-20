#!/bin/bash

sudo pacman -S linux linux-headers --noconfirm
yay -S --noconfirm --needed ncurses5-compat-libs
yay -S --noconfirm --needed  vmware-workstation
#gpg --keyserver pgp.mit.edu --recv-keys F7E48EDB
#sudo sh-edition-version.release.architecture.bundle --console -I --eulas-agreed
yay -S vmware-tools --noconfirm


#reinicir y luego 
#sudo modprobe -a vmw_vmci vmmon

#sudo systemctl start vmware-networks
#sudo systemctl enable vmware-networks



