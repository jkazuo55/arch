#! /bin/bash

 function programasArch {
  #archive formats
  pacman -S --noconfirm p7zip p7zip-plugins rsync
  #compresors
  pacman -S --noconfirm unrar tar file-roller unzip 
  #sistema 
  pacman -S --noconfirm bash-completion 
  pacman -S --noconfirm git
  pacman -S --noconfirm lshw 
  pacman -S --noconfirm xsensors 
  pacman -S --noconfirm testdisk 
  pacman -S --noconfirm tree 
  pacman -S --noconfirm htop 
  pacman -S --noconfirm gparted 
  pacman -S --noconfirm pcmanfm
  pacman -S --noconfirm feh 
  pacman -S --noconfirm flameshot 
  pacman -S --noconfirm simple-scan 
  pacman -S --noconfirm brasero 
  pacman -S --noconfirm mupdf 
  #browser
  pacman -S --noconfirm firefox
  pacman -S --noconfirm opera
  
  #tex editors
  pacman -S --noconfirm vim 
  pacman -S --noconfirm geany
  #impresora
  pacman -S --noconfirm cups 
  pacman -S --noconfirm aria2 
  pacman -S --noconfirm curl 
  pacman -S --noconfirm screenfetch 


  pacman -S --noconfirm arp-scan
  pacman -S --noconfirm gimp 
  pacman -S --noconfirm inkscape 
  pacman -S --noconfirm transmission-gtk 
  pacman -S --noconfirm youtube-dl 

  #programacion
  #pacman -S netbeans composer nodejs-lts-erbium

  #pacman -S thunar thunar-archive-plugin thunar-volman terminator okular cmus cclive clementine wps-office-mui-es-mx whatsapp-nativefier caprine handbrake wps-office-extension-spanish-dictionary translate-shell

  #browser
  yay -S aur/google-chrome-dev --noconfirm
  #fonts
  yay -S aur/ttf-windows --noconfirm
  yay -S aur/ttf-ms-fonts --noconfirm
  yay -S aur/times-newer-roman --noconfirm
  #file manager
  pacman -S ranger w3m --noconfirm
  ranger --copy-config=all
  #program manager
  yay -S aur/pamac-aur #client de administracion de paquetes

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
  vim /etc/pacman.conf
  echo "edision terminada"
 }


function terminal {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    echo ""
    echo "change theme OSH_THEME="powerline-multiline""
    vim /home/jkazuo55/.bashrc
}

function touchpad {
    echo "instalamos touchpad"
    sudo pacman -S xf86-input-synaptics

    #synclient TapButton1=1
    #synclient TapButton2=2
    #synclient TapButton3=3
    echo "agregar en la primera seccion de inputclass"
    echo "Option "TapButton1" "1""
    echo "Option "TapButton2" "2""
    echo "Option "TapButton3" "3""
    sudo vim /usr/share/X11/xorg.conf.d/70-synaptics.conf

}


programasArch