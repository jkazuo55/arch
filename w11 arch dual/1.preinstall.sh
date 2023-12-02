#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

function formatDisk {
    clear
    
    echo -e "${BLUE} FORMAT ROOT PARTITION ${NC}"
    mkfs.ext4 -F -L "root" /dev/sdb4
    echo -e "${GREEN} finiched ${NC}"
    
    # echo -e "FORMAT HOME PARTITION"
    # mkfs.ext4 -F -L "home" /dev/sdb7
    # echo -e "${GREEN} finiched ${NC}"
    
    echo -e "${BLUE} FORMAT SWAP PARTITION ${NC}"
    mkswap -L "SWAP" /dev/sdb5
    echo -e "${GREEN} finiched ${NC}"
}

function prepareInstalation {
    clear
    
    echo -e "${BLUE} MOUNT ROOT ${NC}"
    mount /dev/sdb4 /mnt
    echo -e "${GREEN} finiched ${NC}"
    
    echo -e "${BLUE} CREATE HOME DIRECTORY ${NC}"
    mkdir -p /mnt/home
    echo -e "${GREEN} finiched ${NC}"
    
    # echo -e "montamos home"
    # mount /dev/sdb7 /mnt/home
    # echo -e "directorio home montado en /mnt/home"
    # echo -e "${GREEN} finiched ${NC}"
    
    echo -e "${BLUE} ACTIVATE SWAP ${NC}"
    swapon /dev/sdb5
    echo -e "${GREEN} finiched ${NC}"
    
    echo -e "${BLUE} CREATE DIRECTORY EFI ${NC}"
    mkdir -p /mnt/boot/efi
    echo -e "${GREEN} finiched ${NC}"
    
    echo -e "${BLUE} MOUNT EFI ${NC}"
    mount /dev/sdb1 /mnt/boot/efi
    echo -e "${GREEN} finiched ${NC}"
}

function installBase {
    clear

    echo -e "${BLUE} INSTALL SYSTEM BASE ${NC}"
    pacstrap -i /mnt base base-devel linux linux-firmware linux-headers dhcpcd gvfs-mtp gvfs-afc gvfs-gphoto2 vim git netctl dialog tmux intel-ucode sudo networkmanager nano
    echo -e "${GREEN} finiched ${NC}"
}

function configSystem {
    clear

    echo -e "${BLUE} GEN fstab file ${NC}"    
    genfstab -U /mnt >> /mnt/etc/fstab
    echo -e "${GREEN} finiched ${NC}"
    
    # echo -e "comprobamos que el fichero fue creado correctamente"
    # cat /mnt/etc/fstab
    # echo -e "${GREEN} finiched ${NC}"
}

formatDisk
prepareInstalation
installBase
configSystem
cp 2.install.sh /mnt/root/
cp 3.postinstall.sh /mnt/root/
cp 4.i3.sh /mnt/root/
cp 5.utilities.sh /mnt/root/
arch-chroot /mnt/
swapoff -a
umount -R /mnt
reboot

















