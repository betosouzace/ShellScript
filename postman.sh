#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
  clear
  echo "                       !!! ATENÇÃO !!!"
  echo "              NÃO execute este script como root!"
  echo "              Presione qualquer tecla para sair..."
  read -s -n 1 -p " "
  exit
fi

wget https://dl.pstmn.io/download/latest/linux_64 -O /tmp/postman.tar.gz

sudo rm -rf /opt/Postman
sudo rm -rf /usr/share/applications/postman*.desktop
sudo rm -rf /usr/share/applications/Postman*.desktop
sudo rm -rf /usr/bin/postman

sudo tar -xzf /tmp/postman.tar.gz -C /opt

sudo chmod -R 777 /opt/Postman

sudo ln -s /opt/Postman/app/Postman /usr/bin/postman

# Create proper desktop entry
sudo tee /usr/share/applications/Postman.desktop > /dev/null << 'EOF'
[Desktop Entry]
Version=1.0
Name=Postman
Comment=API Development Environment
GenericName=API Client
Exec=/opt/Postman/app/Postman %U
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
StartupNotify=true
StartupWMClass=Postman
Categories=Development;Network;
Keywords=postman;api;rest;http;client;
MimeType=application/x-postman-collection;
EOF

# Set proper permissions for desktop file
sudo chmod 644 /usr/share/applications/Postman.desktop

# Verify and fix icon path if needed
if [ ! -f "/opt/Postman/app/resources/app/assets/icon.png" ]; then
    echo "Searching for Postman icon..."
    ICON_PATH=$(find /opt/Postman -name "*.png" -path "*/icon*" -o -name "postman*.png" | head -1)
    if [ -n "$ICON_PATH" ]; then
        echo "Found icon at: $ICON_PATH"
        sudo sed -i "s|Icon=.*|Icon=$ICON_PATH|" /usr/share/applications/Postman.desktop
    else
        echo "Icon not found, using generic application icon"
        sudo sed -i "s|Icon=.*|Icon=application-x-executable|" /usr/share/applications/Postman.desktop
    fi
fi

# Update desktop database
if command -v update-desktop-database >/dev/null 2>&1; then
    sudo update-desktop-database /usr/share/applications/
fi

rm -rf /tmp/postman.tar.gz

echo " "
echo "Postman instalado com sucesso!"
echo " "
echo "Para executar o Postman, você pode procurar no menu de aplicativos, ou executar o comando abaixo:"
echo " "
echo "    postman"
echo " "
echo "Para desinstalar o Postman, execute o comando abaixo:"
echo " "
echo "    sudo rm -rf /opt/Postman /usr/share/applications/Postman.desktop /usr/bin/postman && sudo update-desktop-database /usr/share/applications/ 2>/dev/null || true"
echo " "
echo "Pressione qualquer tecla para sair..."
read -s -n 1 -p " "

clear
exit
