#!/bin/bash

 function configClock {
#   echo "Listamos los timezones"
#   timedatectl list-timezones | grep La_Paz
#   echo ""

#   echo "ahora establecemos la zona horaria"
#   ln -sf /usr/share/zoneinfo/America/La_Paz /etc/localtime
#   echo "zona horaria establecida"
#   echo ""

#   echo "configuramos el reloj "
#   hwclock -w
#   echo ""

#   echo "actulizamos el reloj del sistema"
#   timedatectl set-ntp true
#   echo "Reloj configurado y actualizado satisfactoriamente"
#   echo ""

 }

  function datetime {
    echo "configuracion de hora y fecha"
    timedatectl status

    # listar zonas horarias
    # timedatectl list-timezones
       
    echo "change timezone"
    timedatectl set-timezone America/La_Paz

 }

 function languaje {

  echo "ESTABLECEMOS LA ONFIGURACION REGIONAL"
  echo "vim /etc/locale.gen"
  sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
  sed -i 's/#es_BO.UTF-8 UTF-8/es_BO.UTF-8 UTF-8/g' /etc/locale.gen
  echo ""

  echo "generamos la configuracion regional locale-gen"
  locale-gen
  echo ""

  echo "establecemos la variable LANG"
  echo "LANG=en_US.UTF-8" >> /etc/locale.conf
  echo ""

  echo "exportamos la variable LANG"
  export LANG=en_US.UTF-8
  echo ""

  echo "establecemos la variable LC_MESSAGES"
  echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
  echo ""

  echo "ahora verificamos los locale"
  locale
  echo ""

 }

 function loadkeys {
    echo "cargamos loadkeys"
    loadkeys /usr/share/kbd/keymaps/i386/qwerty/us.map.gz
 }

 function hostname {
  echo "configuramos el nombre del host"
  echo "arch" >> /etc/hostname
  echo ""
 }

 function configNetwork {
  echo "configuramos el fichero de host"
  echo "127.0.0.1 localhost" >> /etc/hosts
  echo "::1 localhost" >> /etc/hosts
  echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
  echo ""

#   echo "verificamos"
#   cat /etc/hosts
#   echo ""

 }

 function utilities {

  echo "instalamos programs extras"
  pacman -S netctl --noconfirm
  pacman -S wpa_supplicant --noconfirm
  pacman -S net-tools --noconfirm
  pacman -S ttf-{dejavu,hack,roboto,liberation} --needed --noconfirm
  echo "" 

 }

 function configAccounts {

  echo "root password"
  passwd
  echo ""

  echo "julhuarachi password"
  useradd -m julhuarachi 
  passwd julhuarachi
  usermod -aG wheel,storage,power julhuarachi

 }

 function extraconfig {
    # uncomment %wheel ALL=(ALL:ALL) ALL
    # add this line Defaults timestamp_timeout=0
    sleep 10
    EDITOR=nano visudo
 }

 function configExtra {
  echo "CONFIGURACION EXTRA"
  echo ""
  echo "habilitamos multilib en repositorios"
  echo "vim /etc/pacman.conf"
  #sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf
  #sed -i 's/#Include = \/etc\/pacman.d\/mirrorlist/Include = \/etc\/pacman.d\/mirrorlist/g' /etc/pacman.conf
  echo "[multilib]" >> /etc/pacman.conf
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
  echo "configuracion terminada"
  pacman -Syyu --noconfirm
  #CONFIG EXTRA
  pacman -S --noconfirm extra/alsa-utils
  alsactl init  #activar sonido
  pacman -S pulseaudio pavucontrol --noconfirm
  export arch=x86_64 #variable de entorno

 }

 function others {
    systemctl enable dhcpcd.service
    systemctl enable NetworkManager.service
 }

 function installGrub {
  pacman -S grub efibootmgr dosfstools mtools 
  vim /etc/default/grub 
  # descoment line GRUB_DISABLE_OS_PROBER=false
  pacman -S os-prober 
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub_uefi --recheck 
  grub-mkconfig -o /boot/grub/grub.cfg
 }

 function connectWifi {
    nmcli wlan0 wifi connect libre password holamundo
 }

configClock
datetime
languaje
loadkeys
hostname
configNetwork
configAccounts
extraconfig
others
connectWifi
installGrub
utilities
echo("===========finiched=======")
