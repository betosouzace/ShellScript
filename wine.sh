#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
    clear
    echo "                       !!! ATENÇÃO !!!"
    echo "              NÃO execute este script como root!"
    echo "              Presione qualquer tecla para sair..."
    read -s -n 1 -p " "
    exit
fi

sudo dpkg --add-architecture i386

sudo add-apt-repository ppa:lutris-team/lutris -y && sudo apt update && sudo apt install lutris -y

# wget -nc https://dl.winehq.org/wine-builds/winehq.key
# sudo mv winehq.key /usr/share/keyrings/winehq-archive.key

# wget -nc https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
# sudo mv winehq-focal.sources /etc/apt/sources.list.d/

URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"

wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE focal main"

sudo apt update

sudo apt install --install-recommends winehq-stable -y

# Criando instância 32 bits do wine
sudo rm -rf "/home/beto/.wine"
WINEPREFIX="/home/beto/.wine" WINEARCH=win32 wine wineboot

winetricks cmd corefonts msxml6 riched20 gdiplus dotnet452


read -s -n 1 -p "Pressione alguma tecla para sair..."
exit
