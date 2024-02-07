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

sudo tar -xzf /tmp/postman.tar.gz -C /opt

sudo chmod -R 777 /opt/Postman

sudo ln -s /opt/Postman/Postman /usr/bin/postman

echo -e '[Desktop Entry]\n Version=1.0\n Type=Application\n Name=Postman\n Exec=/usr/bin/postman\n Icon=/opt/Postman/app/resources/app/assets/icon.png\n Categories=Development;Code;\n Terminal=false' | sudo tee /usr/share/applications/postman.desktop

echo " "
echo "Instalação concluída"
read -s -n 1 -p "Pressione Enter para sair..."
exit
