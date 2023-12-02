sudo pacman -S postgresql
#data directory luego de entrar en ella
chown postgres /var/lib/postgres/data
initdb --locale en_US.UTF-8 -D /var/lib/postgres/data
# entrar
# sudo su - postgres
#sudo -i -u postgres
#crear db
#createdb linuxhint
#entrar al db 
# psql linuxhint
# modelador de db
#yay pgmodeler

