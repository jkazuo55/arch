#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
# echo -e "${BLUE} TEXT ${NC}"

function yayAurman {
    clear
    echo -e "${BLUE} INTALL YAY ${NC}"

    sudo pacman -Syyyu --noconfirm
    echo "instalando yay"
    git clone "https://aur.archlinux.org/yay.git"
    cd yay
    makepkg -si
    cd ..
    sudo rm -rf yay
}

function installApps {
    clear

    echo -e "${BLUE} INSTALL APPS ${NC}a"
    # base
    pacman -S linux-headers sudo dialog --noconfirm
    pacman -S gvfs-mtp gvfs-afc gvfs-gphoto2 --noconfirm
    pacman -S dhcpcd --noconfirm
    pacman -S vim nano --noconfirm
    pacman -S  netctl --noconfirm
    pacman -S git --noconfirm
    pacman -S tmux --noconfirm

    pacman -S net-tools --noconfirm
    pacman -S ttf-{dejavu,hack,roboto,liberation} --needed --noconfirm

    # Bluetooth
    pacman -S bluez bluez-tuils pulseaudio-bluetooth reflector --noconfirm
    systemctl enable bluetooth
    # impresora Common Unix Printing System
    pacman -S cups --noconfirm
    
    # servidores espejos
    pacman -S reflector --noconfirm
    
    # networkmanager
    pacman -S networkmanager network-manager-applet --noconfirm
    
    # wepa_supplicant
    pacman -S wireless_tools wpa_supplicant --noconfirm
    
    # manipulate directories and files
    pacman -S xdg-user-dirs xdg-utils --noconfirm

    yayAurman

    pacman -S i3 --noconfirm

    echo -e "${GREEN} install apps fineched ${NC}"


}

function datetime {
    clear
    
    echo -e "${BLUE} CONFIG DATE ${NC}a"
    timedatectl status
    # zones list
    # timedatectl list-timezones
    timedatectl set-timezone America/La_Paz

    echo -e "${GREEN} config finiched ${NC}"
}

function configClock {
    clear
    
    echo -e "${BLUE} CONFIG TIME ${NC}"
    
    #   echo -e "Listamos los timezones"
    #   timedatectl list-timezones | grep La_Paz
    #   echo -e ""
    
    ln -sf /usr/share/zoneinfo/America/La_Paz /etc/localtime
    hwclock --systohc
    timedatectl set-ntp true

    echo -e "${GREEN} config time finish ${NC}"
}

function asynctime {
    clear
    echo -e "${BLUE} ASYNC TIME ${NC}"

    pacman -S ntp --noconfirm
    sudo systemctl enable ntpd
    sudo systemctl start ntpd
    sudo ntpdate pool.ntp.org

    echo -e "${BLUE} async time finish ${NC}"
}

# create swap file
function swapconfig {
    clear
    echo -e "${BLUE} SWAP CONFIG ${NC}"

    fallocate -l 8GB /swap_file
    chmod 600 /swap_file
    mkswap /swap_file
    swapon /swap_file
    echo " " >> /etc/fstab
    echo "# Swap file setup" >> /etc/fstab
    echo "/swap_file      none     swap       defaults       0        0 " >> /etc/fstab

    echo -e "${BLUE} finish ${NC}"
}

function languaje {
    clear
    echo -e "${BLUE} SETTING LANGUAJE ${NC}"
    
    #  regional configuration
    sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
    sed -i 's/#es_BO.UTF-8 UTF-8/es_BO.UTF-8 UTF-8/g' /etc/locale.gen
    #  generamos la configuracion regional locale-gen
    locale-gen
    #  establecemos la variable LANG
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf
    #  exportamos la variable LANG
    export LANG=en_US.UTF-8
    #  establecemos la variable LC_MESSAGES
    echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
    #  ahora verificamos los locale
    locale

    echo -e "${GREEN} setting languaje finish ${NC}"
    
}

function loadkeysHelper {
    clear
    echo -e "${BLUE} LOAD KEYS ${NC}"

    #  cargamos loadkeys
    loadkeys /usr/share/kbd/keymaps/i386/qwerty/us.map.gz

    echo -e "${GREEN} load keys finish ${NC}"
}

function hostname {
    clear
    echo -e "${BLUE} SETTING HOSTNAME ${NC}"

    #  configuramos el nombre del host
    echo "arch" >> /etc/hostname

    echo -e "${CREEN} setting hostname finish ${NC}"
}

function configNetwork {
    clear
    echo -e "${BLUE} CONFIG NETWORK ${NC}"

    #  configuramos el fichero de host
    echo "127.0.0.1 localhost" >> /etc/hosts
    echo "::1 localhost" >> /etc/hosts
    echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
    echo -e "${BLUE} finish ${NC}"
    #   verificamos
    cat /etc/hosts
    
    echo -e "${CREEN} config network finish ${NC}"
}

function configAccounts {
    clear
    echo -e "${BLUE} ACCOUNT SETTINGS ${NC}"

    #  root password
    passwd
    #  julhuarachi password
    useradd -m julhuarachi
    passwd julhuarachi
    usermod -aG wheel,storage,power julhuarachi

    echo -e "${CREEN} account settings finish ${NC}"
    
}

function extraconfig {
    clear
    echo -e "${BLUE} EXTRA CONFIG ${NC}"

    # uncomment %wheel ALL=(ALL:ALL) ALL
    # add this line Defaults timestamp_timeout=0
    sleep 10
    EDITOR=nano visudo

    echo -e "${CREEN} extraconfig finish ${NC}"
}

function configExtra {
    clear
    echo -e "${BLUE} CONFIG EXTRA ${NC}"
    
    # habilitamos multilib en repositorios
    #sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
    #sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf
    echo "[multilib]" >> /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
    pacman -Syyu --noconfirm
    #CONFIG EXTRA
    pacman -S --noconfirm extra/alsa-utils
    alsactl init  #activar sonido
    pacman -S pulseaudio pavucontrol --noconfirm
    export arch=x86_64 #variable de entorno

    echo -e "${CREEN} config extra finish ${NC}"
}

function startServices {
    clear
    echo -e "${BLUE} START SERVICES ${NC}"

    # enable services
    systemctl enable dhcpcd.service
    systemctl enable NetworkManager.service

    echo -e "${CREEN} start services finish ${NC}"
}

function connectWifi {
    clear 
    echo -e "${BLUE} CONNECT WIFI ${NC}"

    nmcli device wlan0 connect libre password holamundo

    echo -e "${CREEN} connect wifi finish ${NC}"
}

function installGrub {
    clear
    echo -e "${BLUE} INSTALL GRUB ${NC}"

    pacman -S grub efibootmgr dosfstools mtools --noconfirm
    vim /etc/default/grub
    # descoment line GRUB_DISABLE_OS_PROBER=false
    pacman -S os-prober
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB    --recheck
    grub-mkconfig -o /boot/grub/grub.cfg

    echo -e "${CREEN} grub finish ${NC}"
}

function servidorGrafico {
    clear
    echo -e "${BLUE} XORG ${NC}"

    # sudo pacman -S xorg xorg-server xorg-xinit
    sudo pacman -S xorg-server xorg-xinit --noconfirm
    # sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
    echo "exec i3" > /home/julhuarachi/.xinitrc
    
    echo -e "${CREEN} xorg finish ${NC}"
}

function videonvidia {
    clear

    pacman -S nvidia nvidia-utils nvidia-settings
}

function videointel {
    clear
    pacman -S xf86-video-intel
}

function displaymanager {
    clear
    echo -e "${BLUE} DISPLAY MANAGER ${NC}"

    pacman -S ly --noconfirm
    systemctl enable ly.service
    # files for custom
    # vim /etc/ly/config.ini
    # vim /usr/lib/systemd/system/ly.service
    
}


installApps
datetime
configClock
asynctime
# swapconfig
languaje
loadkeysHelper
hostname
configNetwork
configAccounts
extraconfig
# configExtra
startServices
connectWifi
installGrub
servidorGrafico
# videonvidia
videointel
displaymanager

