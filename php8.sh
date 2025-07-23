#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
  clear
  echo "                       !!! ATENÇÃO !!!"
  echo "              NÃO execute este script como root!"
  echo "              Presione qualquer tecla para sair..."
  read -s -n 1 -p " "
  exit
fi

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo add-apt-repository ppa:ondrej/php -y

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo pkcon update -y
sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean

sudo apt install openssl mcrypt php8.4 php8.4-mcrypt php8.4-common php8.4-mysql php8.4-sqlite3 php8.4-dom php8.4-bcmath php8.4-xml php8.4-xmlrpc php8.4-curl php8.4-gd php8.4-imagick php8.4-cli php8.4-dev php8.4-imap php8.4-mbstring php8.4-opcache php8.4-soap php8.4-zip php8.4-intl php8.4-cgi php8.4-pgsql php8.4-ldap php8.4-fpm -y

## Parar e remover serviço apache instalado com PHP 8 #
sudo /etc/init.d/apache2 stop
sudo systemctl stop apache2.service
sudo systemctl stop apache2
sudo systemctl disable apache2
# # Fedora e derivados RedHat
# sudo systemctl stop httpd
# sudo systemctl disable httpd
sudo apt remove apache2 -y

## Instalacao Composer #
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

echo " "
echo "Atualizações concluídas"
read -s -n 1 -p "Pressione Enter para sair..."
exit
