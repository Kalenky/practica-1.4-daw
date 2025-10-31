#!/bin/bash

# -e: Fianliza el script cuando hay un error
set -ex

# Importamos nuestro archivo de variables
source .env

# Actualiza los repositorios
apt update

# Creamos el certificado autofirmado
sudo openssl req \
  -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt \
  -subj "/C=$OPENSSL_COUNTRY/ST=$OPENSSL_PROVINCE/L=$OPENSSL_LOCALITY/O=$OPENSSL_ORGANIZATION/OU=$OPENSSL_ORGUNIT/CN=$OPENSSL_COMMON_NAME/emailAddress=$OPENSSL_EMAIL"

# Copiamos el archivo de configuracion de apache para SSL
cp ../conf/default-ssl.conf /etc/apache2/sites-available

# Habilitamos el nuevo virtual host que hemos copiado
a2ensite default-ssl.conf

# Habilitamos el módulo SSL para apache
a2enmod ssl

# Reiniciamos el servicio de apache
systemctl restart apache2

