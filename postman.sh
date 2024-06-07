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

echo -e "[Desktop Entry]\nEncoding=UTF-8\nName=Postman\nExec=/opt/Postman/app/Postman %U\nIcon=/opt/Postman/app/resources/app/assets/icon.png\nTerminal=false\nType=Application\nCategories=Development;" | sudo tee /usr/share/applications/Postman.desktop > /dev/null

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
echo "    sudo rm -rf /opt/Postman /usr/share/applications/Postman*.desktop /usr/share/applications/Postman*.desktop /usr/bin/postman"
echo " "
echo "Pressione qualquer tecla para sair..."
read -s -n 1 -p " "

clear
exit
