#! /bin/bash

 function programasArch {

  sudo pacman -Syyyyu --noconfirm	 
  #archive formats
  sudo pacman -S --noconfirm p7zip rsync
  #compresors
  sudo pacman -S --noconfirm unrar tar file-roller unzip 
  #sistema 
  sudo pacman -S --noconfirm bash-completion 
  sudo pacman -S --noconfirm git
  sudo pacman -S --noconfirm lshw 
  sudo pacman -S --noconfirm xsensors 
  sudo pacman -S --noconfirm testdisk 
  sudo pacman -S --noconfirm tree 
  sudo pacman -S --noconfirm htop 
  sudo pacman -S --noconfirm gparted 
  sudo pacman -S --noconfirm pcmanfm
  sudo pacman -S --noconfirm feh 
  sudo pacman -S --noconfirm flameshot 
  sudo pacman -S --noconfirm simple-scan 
  sudo pacman -S --noconfirm brasero 
  sudo pacman -S --noconfirm mupdf 
  #browser
  sudo pacman -S --noconfirm firefox
  sudo pacman -S --noconfirm opera
  #android 
  sudo pacman -S --noconfirm android-tools
  #tex editors
  sudo pacman -S --noconfirm vim 
  sudo pacman -S --noconfirm geany
  #impresora
  sudo pacman -S --noconfirm cups 
  sudo pacman -S --noconfirm aria2 
  sudo pacman -S --noconfirm curl 
  sudo pacman -S --noconfirm screenfetch 


  sudo pacman -S --noconfirm arp-scan
  sudo pacman -S --noconfirm gimp 
  sudo pacman -S --noconfirm inkscape 
  sudo pacman -S --noconfirm transmission-gtk 
  sudo pacman -S --noconfirm youtube-dl 
  #ordenar
  sudo pacman -S --noconfirm peek
  #programacion
  #pacman -S netbeans composer nodejs-lts-erbium

  #pacman -S thunar thunar-archive-plugin thunar-volman terminator okular cmus cclive clementine wps-office-mui-es-mx whatsapp-nativefier caprine handbrake wps-office-extension-spanish-dictionary translate-shell
  #descargadores
  yay -S aur/megabasterd-bin --noconfirm
  #entretenimiento
  sudo pacman -S --noconfirm telegram-desktop
  yay -S --noconfirm aur/whatsapp-nativefier-dark
    
 #browser
  yay -S aur/google-chrome-dev --noconfirm
  #fonts
  yay -S aur/ttf-windows --noconfirm
  yay -S aur/ttf-ms-fonts --noconfirm
  yay -S aur/times-newer-roman --noconfirm
  #file manager
  sudo pacman -S ranger w3m --noconfirm
  ranger --copy-config=all
  #program manager
  #yay -S aur/pamac-aur #client de administracion de paquetes

  #multimedia
  #yay -S spotify
  yay -S aur/castnow-git --noconfirm

  #Downloader
  yay -S aur/jdownloader2 --noconfirm
  yay -S community/speedtest-cli --noconfirm
  yay -S aur/udemy-dl-git --noconfirm
  #yay xzoon  #zoon para pantalla
  #yay gromit-mpx-git # pintar pantalla
  #cp /usr/etc/gromit-mpx/gromit-mpx.cfg ~/.config/gromit-mpx.cfg
  
  #otros
  yay -S aur/rename --noconfirm

  #programacion
  yay -S community/code --noconfirm
  #maven intellij-idea-community-edition simple-http-server postman
 }
 
  #yay jdk9
  
#  function otrosProgramas {
  #expandrive #cliente para servicios en la nuve drive, onedrive, etc
  #perl-goo-canvas
  #tumbler
  #ffmpegthumbniler
  #ffmpegthumbniler-mp3
  #avidemux-qt
#  }

 function impresora {
  echo "INTALACION IMPRESORA"
  yay -S gutenprint --noconfirm
  sudo usermod -a -G sys jkazuo55
  echo "ingresar a http://localhost:631"
 }

 function confPacman {
  echo "CONFIGURAMOS PACMAN"
  echo ""
  echo "descomentamos Color,TotalDownload"
  sudo vim /etc/pacman.conf
  echo "edision terminada"
 }


function terminal {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    echo ""
    echo "change theme OSH_THEME="powerline-multiline""
    sudo vim /home/jkazuo55/.bashrc
}

function touchpad {
    echo "instalamos touchpad"
    sudo pacman -S xf86-input-synaptics --noconfirm

    #synclient TapButton1=1
    #synclient TapButton2=2
    #synclient TapButton3=3
    echo "agregar en la primera seccion de inputclass"
    echo "Option "TapButton1" "1""
    echo "Option "TapButton2" "2""
    echo "Option "TapButton3" "3""
    sudo vim /usr/share/X11/xorg.conf.d/70-synaptics.conf

}

function packfonts {
   yay -S aur/font-manager --noconfirm
	 yay -S aur/ttf-google-fonts-git
}

function configextra {
  sudo pacman -S dbus --noconfirm
  sudo systemctl enable dbus
  #sudo pacman -S gvfs gvfs-afc #thunar-volman  
}

function gtktheme {
  #listar iconos y temas
  #ls /usr/share/icons/
  #ls /usr/share/themes/
  echo "instalar iconos"
  #sudo pacman -S papirus-icon-theme 
  yay -S flat-remix --noconfirm
  echo "instalar themas" 
  yay -S flat-remix-gtk --noconfirm
  #yay -S numix-gtk-theme-git
  #echo "modificar Papirus-Dark y Numix"
  echo "Flat-Remix-Red-Dark Flat-Remix-GTK-Blue-Darkest"

  sudo vim /usr/share/gtk-3.0/settings.ini
  sudo vim /usr/share/gtk-2.0/gtkrc
  echo "terminado"

}

function samba {
  #ejecutar con sudo sudo bash samba.sh

  yay -S samba gvfs-smb --noconfirm
  #thunar-shares-plugin  //paquete para thunar       
  mkdir -p ~/shared
  sudo chown -R nobody.nobody ~/shared
  sudo chmod -R 777 ~/shared
  sudo touch /etc/samba/smb.conf

  echo "[global]
  workgroup = MYGROUP
  server string = Samba Server
  server role = standalone server
  log file = /var/log/samba/smb-log.%m
  max log size = 50
  dns proxy = no
  map to guest = Bad User

  [shared]
  comment = Temporary file space
  path = /home/jkazuo55/shared
  read only = no
  public = yes
  browseable = yes
  guest ok = yes
  create mask = 777" >> /etc/samba/smb.conf

  sudo smbpasswd -a jkazuo55
  sudo systemctl start smb
  sudo systemctl enable smb

}


programasArch
impresora
confPacman
terminal
touchpad
#packfonts
configextra
gtktheme
samba
