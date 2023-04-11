#!/bin/bash

 function reloj {
  echo "CONFIGURACION DE RELOJ"
  echo ""
  echo "Listamos los timezones"
  timedatectl list-timezones | grep La_Paz
  echo ""
  echo "ahora establecemos la zona horaria"
  ln -sf /usr/share/zoneinfo/America/La_Paz /etc/localtime
  echo "zona horaria establecida"
  echo ""
  echo "configuramos el reloj "
  hwclock -w
  echo "reloj configurado"
  echo ""
  echo "actulizamos el reloj del sistema"
  timedatectl set-ntp true
  echo "Reloj configurado y actualizado satisfactoriamente"
 }

 function lenguaje {
  echo "ESTABLECEMOS LA CONFIGURACION REGIONAL"
  echo "vim /etc/locale.gen"
  sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
  sed -i 's/#es_BO.UTF-8 UTF-8/es_BO.UTF-8 UTF-8/g' /etc/locale.gen
  echo ""
  echo "archivo configurado"
  echo ""
  echo "generamos la configuracion regional locale-gen"
  locale-gen
  echo "establecemos la variable LANG"
  echo "LANG=en_US.UTF-8" >> /etc/locale.conf
  echo ""
  echo "exportamos la variable LANG"
  echo ""
  export LANG=en_US.UTF-8
  echo ""
  echo "establecemos la variable LC_MESSAGES"
  echo ""
  echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf
  echo ""
  echo "ahora verificamos los locale"
  echo ""
  locale
  echo ""
  echo "Lenguaje configurado"
 }

 function red {
  echo "CONFIGURACION DE RED"
  echo ""
  echo "configuramos el nombre del host"
  echo "arch" >> /etc/hostname
  echo ""
  echo "configuramos el fichero de host"
  echo "127.0.0.1 localhost" >> /etc/hosts
  echo "::1 localhost" >> /etc/hosts
  echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
  echo ""
  echo "verificamos"
  cat /etc/hosts
  echo ""
  echo "verificado"
  echo "instalamos programs extras"
  pacman -S netctl --noconfirm
  pacman -S wpa_supplicant --noconfirm
  pacman -S net-tools --noconfirm
  echo "Configuracion red terminada"
 }

 function configRoot {
  echo "ESTABLECEMOS CONTRASENIA ROOT"
  echo ""
  passwd
  echo "Contrasenia creada satisfactoriamente"
 }

 function grubEfi {
  echo "INSTALACION y CONFIGURACION GRUB UEFI"
  echo ""
  #grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
  echo ""
  #habilitar vizualizacion de arranque
  #vim /etc/default/grub quitar quiet 
  echo "instalacion terminado"
  echo ""
  echo "generamos el grub para guardar la configuracion"
  #grub-mkconfig -o /boot/grub/grub.cfg
  echo ""
  #instalamos systemd-boot
  bootctl --path=/boot install
  #configuramos loader
  rm /boot/loader/loader.conf
  echo "default arch" > /boot/loader/loader.conf
  echo "timeout 10" >> /boot/loader/loader.conf
  echo "editor 0" >> /boot/loader/loader.conf
  #configuramos entrada defecto arch
  #echo $(blkid -s PARTUUID -o value /dev/sdb6) > /boot/loader/entries/arch.conf
  #modificamos el archivo
  echo "title ArchLinux" > /boot/loader/entries/arch.conf
  echo "linux /vmlinuz-linux" > /boot/loader/entries/arch.conf
  echo "initrd /initramfs-linux.img" > /boot/loader/entries/arch.conf
  echo "options root=PARTUUID=`echo $(blkid -s PARTUUID -o value /dev/sdb6)`" > /boot/loader/entries/arch.conf

 }

 function configUser {
  echo "CONFIGURAMOS USUARIOS Y GRUPOS "
  echo ""
  useradd -m -g users -G audio,storage,video,wheel,power,input -s /bin/bash jkazuo55
  echo "Usuario Jkazuo55 creado correctamente"
  echo ""
  echo "configurando la contrasenia de jkazuo55"
  passwd jkazuo55
  echo ""
  echo "Contrasenia creada para jkazuo55"
  echo ""
  echo "Descomentamos %wheel All=(All) ALL"
  sleep 10
  EDITOR=vim visudo
  echo ""
  echo "edision terminada"
  echo ""
  echo "instalamos paquetes para creacion de directorios"
  pacman -S xdg-user-dirs --needed --noconfirm
  echo ""
  echo "generamos directorio del usuario"
  xdg-user-dirs-update
  echo ""
  echo "direcotiros creados para jkazazuo55"
 }

 function otrosProgramas {
  echo "INSTALAMOS OTROS PROGRAMAS"
  pacman -S ttf-{dejavu,hack,roboto,liberation} --needed --noconfirm
  echo "programs instalados satisfactoriamente"
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

 reloj
 lenguaje
 red
 configRoot
 grubEfi
 configUser
 otrosProgramas
 configExtra
 echo "========================================="
 echo "CONFIGURACION TERMINADA!!!!"
 echo "========================================="
 
 exit
 exit
 exit

