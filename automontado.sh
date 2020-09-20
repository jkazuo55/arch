#!/bin/bash

sudo pacman -S dbus
sudo systemctl enable dbus
sudo pacman -S gvfs gvfs-afc #thunar-volman
