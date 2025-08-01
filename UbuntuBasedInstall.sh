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

sudo apt install git -y

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
URL_FDM="https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb"
URL_SKYPE="https://go.skype.com/skypeforlinux-64.deb"
URL_TERMIUS="https://autoupdate.termius.com/linux/Termius.deb"
URL_WORKB="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.40-1ubuntu24.04_amd64.deb"
URL_WORKB2="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-dbgsym_8.0.40-1ubuntu24.04_amd64.deb"

DIRETORIO_DOWNLOADS="$PASTA_USUARIO/Downloads/programas"

## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

sudo apt update -y

if [ -f /etc/linuxmint/info ]; then
  sudo mintsources
fi

sudo apt update -y

if [ -f /usr/bin/pkcon ]; then
sudo pkcon update -y
fi

sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

sudo apt install curl -y
sudo apt install software-properties-common -y

## Repositório Nodejs ##
# curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
# curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
# echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Balena Etcher
curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash

# Visual Studio Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

## Adicionando repositórios de terceiros e suporte a Snap (Driver Logitech, Lutris e Drivers Nvidia)##
sudo add-apt-repository "$PPA_GIMP" -y
sudo add-apt-repository "$PPA_INKS" -y
sudo add-apt-repository "$PPA_LIBRE" -y
sudo add-apt-repository "$PPA_PHP" -y
sudo apt-add-repository "$PPA_GRAPHICS_DRIVERS" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE noble main"

sudo apt update -y

if [ -f /usr/bin/pkcon ]; then
  sudo pkcon update -y
fi

sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

## Download e instalaçao de programas externos ##
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_FDM" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_VCODE" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_TERMIUS" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_WORKB" -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_WORKB2" -P "$DIRETORIO_DOWNLOADS"

## Experimental, não sei se vai funcionar
sudo apt install $DIRETORIO_DOWNLOADS/*.deb -y
## Instalando pacotes .deb baixados na sessão anterior ##
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt install -f

sudo apt update -y

if [ -f /usr/bin/pkcon ]; then
  sudo pkcon update -y
fi

sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

# Ativando a opção de ativar nunlock na inicialização
sudo apt install numlockx -y
# Configurações > Janela de início de sessão > Configurações > Ativar Nun Lock do teclado

# As instalações estão separados para em caso de erro de algum pacote, os outros não deixem de ser instalados
sudo apt install apt-transport-https -y
sudo apt install build-essential -y
sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y

if [ -f /etc/linuxmint/info ]; then
  sudo apt install mint-meta-codecs -y
fi
sudo apt install dos2unix -y
sudo apt install language-pack-gnome-pt language-pack-kde-pt language-pack-pt-base -y
sudo apt install winff -y
sudo apt install guvcview -y
sudo apt install flameshot -y
sudo apt install steam-installer steam-devices steam:i386 -y
sudo apt install ratbagd -y
sudo apt install gimp gimp-gmic gmic gimp-plugin-registry -y
sudo apt install p7zip-rar p7zip-full lzma lzma-dev rar unrar-free p7zip ark ncompress -y
sudo apt install qt5-default -y
sudo apt install vlc vlc-l10n -y
sudo apt install gdebi-core -y
sudo apt install gparted -y
sudo apt install inkscape -y
sudo apt install audacity -y
sudo apt install libreoffice libreoffice-l10n-pt-br -y
sudo apt install libreoffice-styl* -y
sudo apt install firefox-locale-pt -y
sudo apt install ttf-mscorefonts-installer -y
sudo apt install ubuntu-restricted-extras -y
# plugins de audio e vídeo
sudo apt install libdvd-pkg ffmpeg libavcodec-extra libdvdcss2 -y
sudo dpkg-reconfigure libdvd-pkg
########
sudo apt install gpart -y
sudo apt install libvulkan1 libvulkan1:i386 libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 -y
sudo apt install libsqlite3-0:i386 -y
sudo apt install filezilla -y
# plugin necessário para distros KDE
sudo apt install network-manager-openvpn -y
sudo apt install vim -y
sudo apt install clang -y
sudo apt install cmake -y
sudo apt install ninja-build -y
sudo apt install pkg-config -y
sudo apt install libgtk-3-dev -y
sudo apt install wget -y
sudo apt install git git-flow -y
sudo apt install zsh -y
sudo apt install net-tools -y
sudo apt install samba -y
sudo apt install xrdp -y

# sudo apt install nodejs -y
sudo apt install gcc -y
sudo apt install g++ -y
sudo apt install make -y
# sudo apt install yarn -y
sudo apt install balena-etcher-electron -y
sudo apt install code -y # or code-insiders
# Necessário para o flutter
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev

sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/betosouzace/ShellScript@master/php8.sh)"

## Instalação do Postman ##
echo "Instalando Postman..."
wget -c "https://dl.pstmn.io/download/latest/linux_64" -O "$PASTA_USUARIO/postman-linux-x64.tar.gz"
sudo tar -xzf "$PASTA_USUARIO/postman-linux-x64.tar.gz" -C /opt/
sudo chmod 777 -R /opt/Postman/

# Criando atalho do Postman na área de aplicações do usuário
cat > "$PASTA_USUARIO/.local/share/applications/Postman.desktop" << 'EOT'
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOT

chown $USER:$USER "$PASTA_USUARIO/.local/share/applications/Postman.desktop"
chmod 755 "$PASTA_USUARIO/.local/share/applications/Postman.desktop"

# Removendo o arquivo tar.gz baixado
rm -f "$PASTA_USUARIO/postman-linux-x64.tar.gz"

echo "Postman instalado com sucesso!"

# Docker
sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/betosouzace/ShellScript@master/docker.sh)"

sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/betosouzace/ShellScript@master/postman.sh)"

# instalação Spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

## Configurando VSCode como editor padrão
sudo update-alternatives --set editor /usr/bin/code
# # Se o Visual Studio Code não aparecer como alternativa ao editor, você precisará registrá-lo:
# sudo update-alternatives --install /usr/bin/editor editor $(which code) 10

# Criando instância 32 bits do wine
sudo rm -rf "$PASTA_USUARIO/.wine"
WINEPREFIX="$PASTA_USUARIO/.wine" WINEARCH=win32 wine wineboot

## Parar e remover serviço apache instalado com PHP 8 #
sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/betosouzace/ShellScript@master/removeApache.sh)"

sudo apt update -y

if [ -f /usr/bin/pkcon ]; then
  sudo pkcon update -y
fi

sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

## Atalho Nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node

## Instalacao Composer #
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

flatpak install flathub io.podman_desktop.PodmanDesktop -y

sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/betosouzace/ShellScript@master/cursor.sh)"

sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/betosouzace/ShellScript@master/zsh.sh)"

# Caso queira instalar o snap descomente as linhas abaixo
# sudo rm /etc/apt/preferences.d/nosnap.pref
# sudo apt install snapd

## Apagando pasta de Downloads #
sudo rm -rf "$DIRETORIO_DOWNLOADS"

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
