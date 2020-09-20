#!/bin/bash

 function logo {
   clear

   echo """

 ___           _        _ _      _             _     
|_ _|_ __  ___| |_ __ _| | |    / \   _ __ ___| |__  
 | || '_ \/ __| __/ _| | | |   / _ \ | '__/ __| '_ \ 
 | || | | \__ \ || (_| | | |  / ___ \| | | (__| | | |
|___|_| |_|___/\__\__,_|_|_| /_/   \_\_|  \___|_| |_|
       
         By. @jkazuo55 | 2020
  """;
  }

 function verificacionDisco {
  echo "VERIFICACION DISCO"
  echo "Constamos tabla de particiones"
  parted -l | egrep "Model|/dev/sd/msdos/gpt"
  echo ""
  echo "identificamos el dispositivo de almacenamiento"
  lsblk -Spo NAME,MODEL,SIZE,VENDOR,RM
  echo ""
  echo "verificamos las particiones creadas"
  lsblk -po NAME,FSTYPE,LABEL,MOUNTPOINT /dev/sda
  echo ""
 }

 function formatearDisco {
  echo "FORMATEO DISCO"
  echo "formateamos particion uefi"
  mkfs.fat -F32 -n "EFI" /dev/sda1
  echo ""
  echo "formateamos particion swap"
  mkswap -L "SWAP" /dev/sda2
  echo ""
  echo "formateamos particion root"
  mkfs.ext4 -F -L "root" /dev/sda3
  echo ""
  echo "formateamos particion home"
  mkfs.ext4 -F -L "home" /dev/sda4
  echo ""
  echo "verificamos las particiones que emos formateado"
  lsblk -po NAME,FSTYPE,LABEL,MOUNTPOINT /dev/sda
  echo ""
 }

 function prepararInstalacion {
  echo "PREPARAR INSTALACION"
  echo ""
  echo "Montamos la raiz"
  mount /dev/sda3 /mnt
  echo "raiz montadada en /mnt"
  echo ""
  echo "creamon directorio home"
  mkdir -p /mnt/home
  echo "directorio home creada en /mnt/home"
  echo ""
  echo "montamos home"
  mount /dev/sda4 /mnt/home
  echo "directorio home montado en /mnt/home"
  echo ""
  echo "activamos swap"
  swapon /dev/sda2
  echo "swap activado"
  echo ""
  echo "creamos directorio efi"
  mkdir -p /mnt/efi
  echo "directorio efi creado en /mnt/efi"
  echo ""
  echo "montamos efi"
  mount /dev/sda1 /mnt/efi
  echo "efi montdo en /mnt/efi"
  echo ""
  echo "verificamos la informacion de montado"
  echo ""
  lsblk -po NAME,FSTYPE,LABEL,MOUNTPOINT /dev/sda
  echo ""
 }

 function instalarSistema {
  echo "INSTALACION DE SISTEMA BASE"
  echo ""
  pacstrap /mnt base base-devel linux linux-firmware grub efibootmgr dhcpcd gvfs-mtp gvfs-afc gvfs-gphoto2 vim git netctl dialog termite tmux
  echo "instalacion terminada con exito"
 }

 function configSistema {
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


 logo
 sleep 5
 clear
 verificacionDisco
 sleep 10
 clear
 formatearDisco
 sleep 20
 clear
 prepararInstalacion
 sleep 30
 clear
 instalarSistema
 sleep 30
 clear
 configSistema
 sleep 30
 echo "==================================================="
 echo "Instalacion y Configuracion Primera parte Terminado"
 echo "==================================================="
 echo ""

 echo """
 "copiamos 2do archivo de instalacion config.sh"
 #cp config.sh /mnt/root/
 
 "Ahora nos pasamos al otro sistema" 
 #arch-chroot /mnt

 "apagamos swap"
 #swapoff -a
 
 "desmontamos todo"
 #umount -R /mnt
 
 "reiniciamos todo y extraemos pendrive!!!!!!!!!!!"
 #reboot

 """;

















