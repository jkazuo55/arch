#!/bin/bash

sudo pacman -S virtualbox
#default 2 arch
sudo pacman -S linux-headers --noconfirm
sudo pacman -S virtualbox-guest-iso
sudo modprobe vboxdrv   #//load module to the kernel
sudo modprobe --verbose --force-vermagic vboxdrv
sudo gpasswd -a jkazuo55 vboxusers
