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

sudo apt-get install wget gpg -y

# remove windsurf alternatives if exists
if [ -f /usr/bin/windsurf ]; then
  sudo update-alternatives --remove-all editor 2>/dev/null || true
  sudo update-alternatives --remove-all windsurf 2>/dev/null || true
fi

# remove windsurf se existir
sudo apt remove windsurf -y && sudo apt autoremove -y && sudo apt clean -y

# remove windsurf-stable.gpg se existir
if [ -f windsurf-stable.gpg ]; then
  rm -f windsurf-stable.gpg
fi

# remove windsurf.list se existir
if [ -f /etc/apt/sources.list.d/windsurf.list ]; then
  sudo rm -f /etc/apt/sources.list.d/windsurf.list
fi

wget -qO- "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | gpg --dearmor > windsurf-stable.gpg
sudo install -D -o root -g root -m 644 windsurf-stable.gpg /etc/apt/keyrings/windsurf-stable.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/windsurf-stable.gpg] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
rm -f windsurf-stable.gpg

sudo apt install apt-transport-https -y && sudo apt update -y

sudo apt install windsurf -y

echo " "
echo "Windsurf instalado com sucesso!"
echo " "
echo "Para executar o Windsurf, você pode procurar no menu de aplicativos, ou executar o comando abaixo:"
echo " "
echo "    windsurf"
echo " "
echo "Pressione qualquer tecla para sair..."
read -s -n 1 -p " "

clear
exit