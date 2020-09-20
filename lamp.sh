#!/bin/bash

#apache
sudo pacman -Syu
sudo pacman -S apache --noconfirm  #instalamos apache 2
sudo systemctl restart httpd   #reiniciamos servicio httpd
#php
sudo pacman -S php php-apache --noconfirm #instalamos php y php-apache
#mysql
sudo pacman -S mysql --noconfirm  #instalamos mysql
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql #ejecutamos el demonio de mysql
sudo systemctl enable mysqld #habilitamos mysqld
sudo systemctl start mysqld.service #reiniciamos mysqld
#sudo systemctl status mysqld #verificamos su estado
sudo mysql_secure_installation #configuramos la contrasenia

#composer
sudo pacman -S composer --noconfirm

#composer
sudo pacman -S phpmyadmin --noconfirm


:<<-!
# Use for PHP 7.x:
LoadModule php7_module modules/libphp7.so
AddHandler php7-script php
Include conf/extra/php7_module.conf


# para cargar los index.php si se encuentran en el directorio
<IfModule dir_module>
  <IfModule php7_module>
    	DirectoryIndex index.php index.html
	<FilesMatch "\.php$">
	   SetHandler application/x-httpd-php
	</FilesMatch>
	<FilesMatch "\.phps$">
	   SetHandler application/x-httpd-php-source
	</FilesMatch>
   </IfModule>
</IfModule>

!



