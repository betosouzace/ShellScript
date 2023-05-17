#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
  clear
  echo "                       !!! ATENÇÃO !!!"
  echo "              NÃO execute este script como root!"
  echo "              Presione qualquer tecla para sair..."
  read -s -n 1 -p " "
  exit
fi

# ----------------------------- VARIÁVEIS ----------------------------- #

sudo apt install git git-flow -y

read -p "Digite o username GIT :" GIT_USER
read -p "Digite o email GIT :" GIT_EMAIL

# GIT_USER="seuUsuarioGit"
# GIT_EMAIL="seuemailgit@email.com"

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor vim
git config --global init.defaultBranch "main"
git config --list

git config --global core.editor vim
git config --global init.defaultBranch main
git config --global pull.rebase false

PASTA_USUARIO=$HOME

PPA_PHP="ppa:ondrej/php"

URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_TERMIUS="https://autoupdate.termius.com/linux/Termius.deb"
URL_WORKB="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.33-1ubuntu22.04_amd64.deb"

DIRETORIO_DOWNLOADS="$PASTA_USUARIO/Downloads/programas"

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo pkcon update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

sudo apt install curl -y
sudo apt install software-properties-common -y

# Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo add-apt-repository "$PPA_PHP" -y

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo pkcon update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_TERMIUS" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_WORKB" -P "$DIRETORIO_DOWNLOADS"

## Experimental, não sei se vai funcionar
sudo apt install $DIRETORIO_DOWNLOADS/*.deb -y
## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt install -f

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo pkcon update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

# As instalações estão separados para em caso de erro de algum pacote, os outros não deixem de ser instalados
sudo apt install apt-transport-https -y
sudo apt install build-essential -y
# A linha abaixo atualiza os codecs do Linux Mint:
sudo apt install mint-meta-codecs -y
sudo apt install dos2unix -y
sudo apt install language-pack-gnome-pt language-pack-kde-pt language-pack-pt-base -y
sudo apt install steam-installer steam-devices steam:i386 -y
sudo apt install p7zip-rar p7zip-full lzma lzma-dev rar unrar-free p7zip ark ncompress -y
sudo apt install vlc vlc-l10n -y
sudo apt install firefox-locale-pt -y
sudo apt install ubuntu-restricted-extras -y
# plugins de audio e vídeo
sudo apt install libsqlite3-0:i386 -y
sudo apt install filezilla -y
# plugin necessário para distros KDE
sudo apt install network-manager-openvpn -y
sudo apt install vim -y
sudo apt install clang -y
sudo apt install cmake -y
sudo apt install wget -y
sudo apt install git git-flow -y
sudo apt install zsh -y
sudo apt install net-tools -y
sudo apt install samba -y
sudo apt install xrdp -y
# PHP e extensões necessárias para o Laravel 9
sudo apt install openssl mcrypt php8.2 php8.2-mcrypt php8.2-common php8.2-mysql php8.2-sqlite3 php8.2-dom php8.2-bcmath php8.2-xml php8.2-xmlrpc php8.2-curl php8.2-gd php8.2-imagick php8.2-cli php8.2-dev php8.2-imap php8.2-mbstring php8.2-opcache php8.2-soap php8.2-zip php8.2-intl php8.2-cgi php8.2-pgsql php8.2-ldap -y
sudo apt install php8.2-{mcrypt,common,mysql,sqlite3,dom,bcmath,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl,cgi,pgsql,ldap} -y
# sudo apt install nodejs -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install make -y
# sudo apt install yarn -y
sudo apt install code -y # or code-insiders
# Necessário para o flutter

# Definindo zsh como shell padrão
chsh -s $(which zsh)
chsh -s /usr/bin/zsh
sudo usermod -s /usr/bin/zsh $(whoami)
chsh -s /bin/zsh
sudo chsh -s /bin/zsh

## Configurando VSCode como editor padrão
sudo update-alternatives --set editor /usr/bin/code
# # Se o Visual Studio Code não aparecer como alternativa ao editor, você precisará registrá-lo:
# sudo update-alternatives --install /usr/bin/editor editor $(which code) 10

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
sudo pkcon update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

## Instalacao Composer #
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

# Caso queira instalar o snap descomente as linhas abaixo
# sudo rm /etc/apt/preferences.d/nosnap.pref
# sudo apt install snapd

flatpak install flathub com.getpostman.Postman -y
flatpak update

## Apagando pasta de Downloads #
sudo rm -rf "$DIRETORIO_DOWNLOADS"

## Configuracao SSH GIT para o github #
ssh-keygen -t ed25519 -C "$GIT_EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# ## Para instalar o XAMPP 5.5.38 descomente as linhas abaixo#
# wget https://ufpr.dl.sourceforge.net/project/xampp/XAMPP%20Linux/5.5.38/xampp-linux-x64-5.5.38-3-installer.run
# sudo chmod 755 xampp-linux-x64-5.5.38-3-installer.run
# sudo ./xampp-linux-x64-5.5.38-3-installer.run --installer-language pt_BR
# sudo rm xampp-linux*
# sudo ln -s /opt/lampp/htdocs/ $PASTA_USUARIO/htdocs
# sudo chmod 777 -R $PASTA_USUARIO/htdocs
# sudo sed -i 's/display_errors=On/display_errors=Off/g' /opt/lampp/etc/php.ini
# sudo sed -i 's/short_open_tag=Off/short_open_tag=On/g' /opt/lampp/etc/php.ini
# rm -f $PASTA_USUARIO/.local/share/applications/XAMPP.desktop
# rm -f $PASTA_USUARIO/Desktop/XAMPP.desktop
# rm -f "$PASTA_USUARIO/Área de Trabalho/XAMPP.desktop"
# sudo rm -f /usr/share/applications/XAMPP.desktop

# cat >"$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" <<EOT
# [Desktop Entry]
# Encoding=UTF-8
# Type=Application
# Name=XAMPP Control Panel
# Comment=Start and Stop XAMPP
# Exec=sudo /opt/lampp/manager-linux-x64.run
# Icon=/opt/lampp/htdocs/favicon.ico
# Categories=Development
# Type=Application
# Terminal=true
# EOT

# chown $USER:$USER -R "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop"
# chmod 755 -R "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop"
# ln -s "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" $PASTA_USUARIO/Desktop/XAMPP.desktop
# ln -s "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" "$PASTA_USUARIO/Área de Trabalho/XAMPP.desktop"
# sudo cp "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" /usr/share/applications/XAMPP.desktop
# sudo chmod 755 -R /usr/share/applications/XAMPP.desktop
# echo "XAMPP Instalado com sucesso!"
# ## Crinado Link simbólico Mysql #
# sudo ln -s /opt/lampp/bin/mysql /usr/bin/mysql

# #### clear
echo "Adicione as informações abaixo ao seu github:"
echo ""
cat ~/.ssh/id_ed25519.pub

echo " "
echo "Atualizações concluídas"
read -s -n 1 -p "Pressione Enter para sair..."
exit
