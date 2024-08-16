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

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

sudo apt install curl -y
sudo apt install software-properties-common -y

# As instalações estão separados para em caso de erro de algum pacote, os outros não deixem de ser instalados
sudo apt install apt-transport-https -y
sudo apt install build-essential -y

sudo apt install dos2unix -y
sudo apt install p7zip-rar p7zip-full lzma lzma-dev rar unrar-free p7zip ark ncompress -y
sudo apt install libsqlite3-0:i386 -y
sudo apt install vim -y
sudo apt install wget -y
sudo apt install git git-flow -y
sudo apt install zsh -y
sudo apt install net-tools -y
sudo apt install samba -y
sudo apt install openssl mcrypt php8.2 php8.2-mcrypt php8.2-common php8.2-mysql php8.2-sqlite3 php8.2-dom php8.2-bcmath php8.2-xml php8.2-xmlrpc php8.2-curl php8.2-gd php8.2-imagick php8.2-cli php8.2-dev php8.2-imap php8.2-mbstring php8.2-opcache php8.2-soap php8.2-zip php8.2-intl php8.2-cgi php8.2-pgsql php8.2-ldap -y
sudo apt install php8.2-{mcrypt,common,mysql,sqlite3,dom,bcmath,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl,cgi,pgsql,ldap} -y
# sudo apt install nodejs -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install make -y

# Definindo zsh como shell padrão
# chsh -s $(which zsh)
# chsh -s /usr/bin/zsh
# sudo usermod -s /usr/bin/zsh $(whoami)
# chsh -s /bin/zsh
# sudo chsh -s /bin/zsh

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER

## Parar e remover serviço apache instalado com PHP 8 #
sudo /etc/init.d/apache2 stop
sudo systemctl stop apache2.service
sudo systemctl stop apache2
sudo systemctl disable apache2
# # Fedora e derivados RedHat
# sudo systemctl stop httpd
# sudo systemctl disable httpd
sudo apt remove apache2 -y

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

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
