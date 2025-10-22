#!/bin/bash
# -e: Fianliza el script cuando hay un error
set -ex
# Actualiza los repositorios
apt update

# Actualizamos los paquetes
apt upgrade -y

# Instalamos el servidor apache
apt install apache2 -y

#Instalamos PHP
apt install php libapache2-mod-php- php-mysql -y

# Copiamos el archivo de configuraicópn de Apache
cp ../conf/000-default.conf /etc/apache2/sites-available

# Reiniciar el servicio apache
systemctl restart apache2

#Copiamos nuestro archivo de prueba php a /var
cp ../php/index.php /var/www/html
