#!/bin/bash

 function formatDisk {

  echo "formateamos particion root"
  mkfs.ext4 -F -L "root" /dev/sdb4
  echo ""

  # echo "formateamos particion home"
  # mkfs.ext4 -F -L "home" /dev/sdb7
  # echo ""

  echo "formateamos particion swap"
  mkswap -L "SWAP" /dev/sdb5
  echo ""

 }

 function prepareInstalation {

  echo "Montamos la raiz"
  mount /dev/sdb4 /mnt
  echo "raiz montadada en /mnt"
  echo ""

  echo "creamon directorio home"
  mkdir -p /mnt/home
  echo "directorio home creada en /mnt/home"
  echo ""

  # echo "montamos home"
  # mount /dev/sdb7 /mnt/home
  # echo "directorio home montado en /mnt/home"
  # echo ""

  echo "activamos swap"
  swapon /dev/sdb5
  echo "swap activado"
  echo ""

  echo "creamos directorio efi"
  mkdir -p /mnt/boot/efi
  echo "directorio efi creado en /mnt/boot/efi"
  echo ""

  echo "montamos efi"
  mount /dev/sdb1 /mnt/boot/efi
  echo "efi montado en /mnt/boot/efi"
  echo ""

 }

 function datetime {
    echo "configuracion de hora y fecha"
    timedatectl status

    # listar zonas horarias
    # timedatectl list-timezones
       
    echo "change timezone"
    timedatectl set-timezone America/La_Paz

 }

 function fastrepository {
  cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  pacman -Sy 
  pacman -S pacman-contrib --noconfirm 
  rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
 }

 function installBase {
  echo "INSTALACION DE SISTEMA BASE"
  echo ""

  pacstrap -i /mnt base base-devel linux linux-firmware linux-headers dhcpcd gvfs-mtp gvfs-afc gvfs-gphoto2 vim git netctl dialog tmux intel-ucode sudo networkmanager pulseaudio nano
  echo "instalacion terminada con exito"
 }

 function configSystem {
  echo "CONFIGURACION DEL SISTEMA"
  echo ""

  echo "generar fichero fstab"
  genfstab -U /mnt >> /mnt/etc/fstab
  echo "fstab generado en /mnt/etc/fstab"
  echo ""

  echo "comprobamos que el fichero fue creado correctamente"
  echo ""
  cat /mnt/etc/fstab
  echo ""
 }

formatDisk
prepareInstalation
datetime
fastrepository
installBase
configSystem

 cp 2.config.sh /mnt/root/
 arch-chroot /mnt/
 swapoff -a
 umount -R /mnt
 reboot

















