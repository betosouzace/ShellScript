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
GIT_USER="seuUsuarioGit"
GIT_EMAIL="seuemailgit@email.com"

PASTA_USUARIO=$HOME

PPA_GIMP="ppa:ubuntuhandbook1/gimp"
PPA_LIBRE="ppa:libreoffice/ppa"
PPA_INKS="ppa:inkscape.dev/stable"
PPA_PHP="ppa:ondrej/php"
PPA_GRAPHICS_DRIVERS="ppa:graphics-drivers/ppa"

URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.18.5-1_amd64.deb"
URL_ANYDESK="https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb"
URL_FDM="https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb"
URL_VCODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_SKYPE="https://go.skype.com/skypeforlinux-64.deb"
URL_WORKB="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.27-1ubuntu20.04_amd64.deb"

DIRETORIO_DOWNLOADS="$PASTA_USUARIO/Downloads/programas"

PROGRAMAS_PARA_INSTALAR=(
  dos2unix
  language-pack-gnome-pt
  language-pack-kde-pt
  language-pack-pt-base
  winff
  guvcview
  flameshot
  steam-installer
  steam-devices
  steam:i386
  ratbagd
  gimp
  gimp-gmic
  gmic
  gimp-plugin-registry
  p7zip-rar
  p7zip-full
  lzma
  lzma-dev
  rar
  unrar-free
  p7zip
  ark
  ncompress
  qt5-default
  vlc
  vlc-l10n
  gdebi-core
  gparted
  inkscape
  audacity
  libdvd-pkg
  libreoffice
  libreoffice-styl*
  libreoffice-l10n-pt-br
  firefox-locale-pt
  libavcodec-extra
  ttf-mscorefonts-installer
  ubuntu-restricted-extras
  apt-transport-https
  ffmpeg
  libavcodec-extra
  libdvdcss2
  gpart
  build-essential
  libvulkan1
  libvulkan1:i386
  libgnutls30:i386
  libldap-2.4-2:i386
  libgpg-error0:i386
  libxml2:i386
  libasound2-plugins:i386
  libsdl2-2.0-0:i386
  libfreetype6:i386
  libdbus-1-3:i386
  libsqlite3-0:i386
  filezilla
  vim
  clang
  cmake
  ninja-build
  pkg-config
  libgtk-3-dev
  wget
  git
  git-flow
  zsh
  net-tools
  php8.0
  php8.0-intl
  php8.0-mysql
  php8.0-sqlite3
  php8.0-gd
  nodejs
  gcc
  g++
  make
  yarn
  npm
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

## Atualizando o repositório ##
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean && sudo apt autoremove -y

sudo apt install curl -y
sudo apt install software-properties-common -y

## Repositório Nodejs ##
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo add-apt-repository "$PPA_GIMP" -y
sudo add-apt-repository "$PPA_INKS" -y
sudo add-apt-repository "$PPA_LIBRE" -y
sudo add-apt-repository "$PPA_PHP" -y
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE focal main"

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean && sudo apt autoremove -y

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
wget -c "$ANYDESK" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_FDM" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VCODE" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_SKYPE" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_WORKB" -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

sudo apt install -f

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

sudo dpkg-reconfigure libdvd-pkg

sudo rm /etc/apt/preferences.d/nosnap.pref

sudo apt install snapd

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##

## Instalando pacotes Snap ##
sudo snap install termius-app
sudo snap install flutter --classic

## Instalando pacotes Flatpak ##
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.google.AndroidStudio -y

# ---------------------------------------------------------------------- #

sudo apt install -f

# Balena Etcher
curl -1sLf \
  'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' |
  sudo -E bash
sudo apt-get update
sudo apt-get install balena-etcher-electron

# Atualizações
sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean && sudo apt autoremove -y
flatpak update
sudo snap refresh
# ---------------------------------------------------------------------- #

## Configuracoes do flutter #
flutter sdk-path
flutter config --no-analytics
flutter upgrade

## Configuracao GIT #
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor vim
git config --list
ssh-keygen -t ed25519 -C "$GIT_EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

## Instalacao Composer #
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

## Parar e remover serviço apache instalado com PHP 8 #
sudo /etc/init.d/apache2 stop
sudo systemctl stop apache2.service
sudo systemctl stop apache2
sudo systemctl disable apache2
sudo apt remove apache2 -y

## Instalacao XAMPP 5.6 #
if [ ! -d "/opt/lampp/etc" ]; then
  wget https://ufpr.dl.sourceforge.net/project/xampp/XAMPP%20Linux/5.6.40/xampp-linux-x64-5.6.40-1-installer.run
  sudo chmod 755 xampp-linux-x64-5.6.40-1-installer.run
  sudo ./xampp-linux-x64-5.6.40-1-installer.run --mode text --installer-language pt_BR
  sudo rm xampp-linux*
  sudo ln -s /opt/lampp/htdocs/ $PASTA_USUARIO/htdocs
  sudo chmod 777 -R $PASTA_USUARIO/htdocs
  sudo sed -i 's/display_errors=On/display_errors=Off/g' /opt/lampp/etc/php.ini
  sudo sed -i 's/short_open_tag=Off/short_open_tag=On/g' /opt/lampp/etc/php.ini
  rm -f $PASTA_USUARIO/.local/share/applications/XAMPP.desktop
  rm -f $PASTA_USUARIO/Desktop/XAMPP.desktop
  rm -f "$PASTA_USUARIO/Área de Trabalho/XAMPP.desktop"
  sudo rm -f /usr/share/applications/XAMPP.desktop
  cat >"$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" <<EOT
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=XAMPP Control Panel
Comment=Start and Stop XAMPP
Exec=sudo /opt/lampp/manager-linux-x64.run
Icon=/opt/lampp/htdocs/favicon.ico
Categories=Development
Type=Application
Terminal=true
EOT
  chown $USER:$USER -R "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop"
  chmod 755 -R "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop"
  ln -s "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" $PASTA_USUARIO/Desktop/XAMPP.desktop
  ln -s "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" "$PASTA_USUARIO/Área de Trabalho/XAMPP.desktop"
  sudo cp "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" /usr/share/applications/XAMPP.desktop
  sudo chmod 755 -R /usr/share/applications/XAMPP.desktop
  echo "XAMPP Instalado com sucesso!"
  ## Crinado Link simbólico Mysql #
  sudo ln -s /opt/lampp/bin/mysql /usr/bin/mysql
# sudo /opt/lampp/lampp start
# xdg-open http://localhost
else
  echo "Já exite uma instalação do XAMPP"
fi

## Apagando pasta de Downloads #
sudo rm -rf "$DIRETORIO_DOWNLOADS"

clear
echo "Adicione as informações abaixo ao seu github:"
echo ""
cat ~/.ssh/id_ed25519.pub

echo " "
echo "Atualizações concluídas"
read -s -n 1 -p "Pressione Enter para sair..."
exit
