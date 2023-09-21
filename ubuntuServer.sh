#!/usr/bin/env bash

# Atualizando o sistema
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

sudo dpkg --add-architecture i386
sudo apt install curl wget -y
sudo apt install software-properties-common -y
sudo apt install apt-transport-https -y
sudo apt install build-essential -y
sudo apt install dos2unix -y
sudo apt install p7zip-rar p7zip-full lzma lzma-dev rar unrar-free p7zip ark ncompress -y
sudo apt install git git-flow -y
sudo apt install libsqlite3-0:i386 -y
sudo apt install network-manager-openvpn -y
sudo apt install vim -y
sudo apt install clang -y
sudo apt install cmake -y
sudo apt install ninja-build -y
sudo apt install pkg-config -y
sudo apt install wget -y
sudo apt install git git-flow -y
sudo apt install zsh -y
sudo apt install net-tools -y
sudo apt install samba -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install make -y
sudo apt-get install clang cmake ninja-build pkg-config liblzma-dev -y

# Instalando o apache
sudo apt-get install apache2 -y

# # Instalando o php
# sudo add-apt-repository ppa:ondrej/php -y
# sudo apt-get update

# Instalando o php 8.2
sudo apt install openssl mcrypt php8.2 php8.2-mcrypt php8.2-common php8.2-mysql php8.2-sqlite3 php8.2-dom php8.2-bcmath php8.2-xml php8.2-xmlrpc php8.2-curl php8.2-gd php8.2-imagick php8.2-cli php8.2-dev php8.2-imap php8.2-mbstring php8.2-opcache php8.2-soap php8.2-zip php8.2-intl php8.2-cgi php8.2-pgsql php8.2-ldap -y

## Instalacao Composer #
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

# instala o certbot e o certbot-apache para gerar o certificado SSL
sudo apt install certbot python3-certbot-apache -y

# Instalando o mysql
sudo apt install mysql-server -y

# # gera a senha do mysql
# sudo mysql_secure_installation

# Atualizando o sistema
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

# Definindo zsh como shell padrão
chsh -s $(which zsh)
chsh -s /usr/bin/zsh
sudo usermod -s /usr/bin/zsh $(whoami)
chsh -s /bin/zsh
sudo chsh -s /bin/zsh