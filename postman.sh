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

echo -e '[Desktop Entry]\n Encoding=UTF-8\n Name=Postman\n Exec=/opt/Postman/app/Postman %U\n Icon=/opt/Postman/app/resources/app/assets/icon.png\n Terminal=false\n Type=Application\n Categories=Development;' | sudo tee /usr/share/applications/postman.desktop

echo " "
echo "Instalação concluída"
read -s -n 1 -p "Pressione Enter para sair..."
exit
