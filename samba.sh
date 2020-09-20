#!/bin/bash

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


