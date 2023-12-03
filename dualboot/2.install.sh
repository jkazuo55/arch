#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
# echo -e "${BLUE} TEXT ${NC}"

function datetime {
    clear
    
    echo -e "${BLUE} CONFIG TIMEZONE ${NC}a"
    timedatectl status
    # listar zonas horarias
    # timedatectl list-timezones
    timedatectl set-timezone America/La_Paz
    echo -e "${GREEN} finish ${NC}"
}

function configClock {
    clear
    
    echo -e "${BLUE} CONFIG TIME ${NC}"
    
    #   echo -e "Listamos los timezones"
    #   timedatectl list-timezones | grep La_Paz
    #   echo -e ""
    
    echo -e "ahora establecemos la zona horaria"
    ln -sf /usr/share/zoneinfo/America/La_Paz /etc/localtime
    echo -e "zona horaria establecida"
    echo -e " "
    
    echo -e "configuramos el reloj "
    hwclock --systohc
    echo -e ""
    echo -e " "
    
    echo -e "actulizamos el reloj del sistema"
    timedatectl set-ntp true
    echo -e "Reloj configurado y actualizado satisfactoriamente"
    echo -e ""
    
}

function asynctime {
    clear
    
    echo -e "${BLUE} ASYNC TIME ${NC}"
    pacman -S ntp --noconfirm
    sudo systemctl enable ntpd
    sudo systemctl start ntpd
    sudo ntpdate pool.ntp.org
    echo -e "${BLUE} finish ${NC}"
}

# create swap file
function swapconfig {
    clear
    echo -e "${BLUE} SWAP CONFIG ${NC}"
    fallocate -l 8GB /swap_file
    chmod 600 /swap_file
    mkswap /swap_file
    swapon /swap_file
    echo -e " " >> /etc/fstab
    echo -e "# Swap file setup" >> /etc/fstab
    echo -e "/swap_file      none     swap       defaults       0        0 " >> /etc/fstab
    echo -e "${BLUE} finish ${NC}"
}

function languaje {
    clear
    
    echo -e "${BLUE} LANGUAJE ${NC}"
    
    echo -e "ESTABLECEMOS LA ONFIGURACION REGIONAL"
    echo -e "vim /etc/locale.gen"
    sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
    sed -i 's/#es_BO.UTF-8 UTF-8/es_BO.UTF-8 UTF-8/g' /etc/locale.gen
    echo -e ""
    
    echo -e "generamos la configuracion regional locale-gen"
    locale-gen
    echo -e ""
    
    echo -e "establecemos la variable LANG"
    echo -e "LANG=en_US.UTF-8" >> /etc/locale.conf
    echo -e ""
    
    echo -e "exportamos la variable LANG"
    export LANG=en_US.UTF-8
    echo -e ""
    
    echo -e "establecemos la variable LC_MESSAGES"
    echo -e "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
    echo -e ""
    
    echo -e "ahora verificamos los locale"
    locale
    echo -e "${GREEN} finish ${NC}"
    
}

function loadkeysHelper {
    clear
    echo -e "${BLUE} LOAD KEYS ${NC}"
    echo -e "cargamos loadkeys"
    loadkeys /usr/share/kbd/keymaps/i386/qwerty/us.map.gz
    echo -e "${GREEN} finish ${NC}"
}

function hostname {
    clear
    echo -e "${BLUE} HOSTNAME ${NC}"
    echo -e "configuramos el nombre del host"
    echo -e "arch" >> /etc/hostname
    echo -e "${BLUE} finish ${NC}"
}

function configNetwork {
    clear
    echo -e "${BLUE} CONFIG NETWORK ${NC}"
    echo -e "configuramos el fichero de host"
    echo -e "127.0.0.1 localhost" >> /etc/hosts
    echo -e "::1 localhost" >> /etc/hosts
    echo -e "127.0.1.1 arch.localdomain arch" >> /etc/hosts
    echo -e "${BLUE} finish ${NC}"
    
    #   echo -e "verificamos"
    #   cat /etc/hosts
    #   echo -e ""
    
}

function configAccounts {
    clear
    echo -e "root password"
    passwd
    echo -e ""
    
    echo -e "julhuarachi password"
    useradd -m julhuarachi
    passwd julhuarachi
    usermod -aG wheel,storage,power julhuarachi
    
}

function extraconfig {
   clear
    # uncomment %wheel ALL=(ALL:ALL) ALL
    # add this line Defaults timestamp_timeout=0
    sleep 10
    EDITOR=nano visudo
}

function configExtra {
    echo -e "CONFIGURACION EXTRA"
    echo -e ""
    echo -e "habilitamos multilib en repositorios"
    echo -e "vim /etc/pacman.conf"
    #sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
    #sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf
    echo -e "[multilib]" >> /etc/pacman.conf
    echo -e "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
    echo -e "configuracion terminada"
    pacman -Syyu --noconfirm
    #CONFIG EXTRA
    pacman -S --noconfirm extra/alsa-utils
    alsactl init  #activar sonido
    pacman -S pulseaudio pavucontrol --noconfirm
    export arch=x86_64 #variable de entorno
    
}

function others {
    echo -e "enable services"
    systemctl enable dhcpcd.service
    systemctl enable NetworkManager.service
}

function connectWifi {
    nmcli device wlan0 connect libre password holamundo
}

function installGrub {
    echo -e "install and config grub efi"
    pacman -S grub efibootmgr dosfstools mtools
    vim /etc/default/grub
    # descoment line GRUB_DISABLE_OS_PROBER=false
    pacman -S os-prober
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB    --recheck
    grub-mkconfig -o /boot/grub/grub.cfg
}

function videonvidia {
    pacman -S nvidia nvidia-utils nvidia-settings
}

function videointel {
    pacman -S xf86-video-intel
}

function displaymanager {
    pacman -S ly --noconfirm
    systemctl enable ly.service
    # files for custom
    # vim /etc/ly/config.ini
    # vim /usr/lib/systemd/system/ly.service
    
}

function utilities {
    
    echo -e "instalamos programs extras"
    pacman -S dialog --noconfirm
    pacman -S netctl --noconfirm
    pacman -S wpa_supplicant --noconfirm
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
    pacman -S network-manager-applet --noconfirm
    
    # wepa_supplicant
    pacman -S wireless_tools wpa_supplicant --noconfirm
    
    # manipulate directories and files
    pacman -S xdg-user-dirs xdg-utils --noconfirm
    
    
    echo -e ""
    
}

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
others
connectWifi
installGrub
videonvidia
videointel
displaymanager
utilities
