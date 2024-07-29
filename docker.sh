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

read -p "Informe a versão do ubuntu (focal, jammy ou noble) :" DISTRO

# Docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $DISTRO stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER

echo " "
echo "Atualizações concluídas"
read -s -n 1 -p "Pressione Enter para sair..."
exit
