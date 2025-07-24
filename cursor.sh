#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
    clear
    echo "                       !!! ATENÇÃO !!!"
    echo "              NÃO execute este script como root!"
    echo "              Presione qualquer tecla para sair..."
    read -s -n 1 -p " "
    exit
fi

sudo apt update -y

if [ -f /usr/bin/pkcon ]; then
  sudo pkcon update -y
fi

sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean
flatpak update -y

flatpak install flathub it.mijorus.gearlever -y

CURSOR_API_URL="https://cursor.com/api/download?platform=linux-x64&releaseTrack=stable"
CURSOR_DOWNLOAD_INFO=$(curl -s "$CURSOR_API_URL")
CURSOR_DOWNLOAD_URL=$(echo "$CURSOR_DOWNLOAD_INFO" | grep -o '"downloadUrl":"[^"]*' | cut -d'"' -f4)

if [ -n "$CURSOR_DOWNLOAD_URL" ]; then
    echo "Baixando Cursor..."
    wget -O "$HOME/Downloads/Cursor.AppImage" "$CURSOR_DOWNLOAD_URL"
    chmod +x "$HOME/Downloads/Cursor.AppImage"
    
    # Open with GearLever
    flatpak run it.mijorus.gearlever "$HOME/Downloads/Cursor.AppImage"
    
    echo "Cursor baixado e aberto no GearLever!"
else
    echo "Erro ao obter URL de download do Cursor"
fi