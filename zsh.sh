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
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando/Confirmando arquitetura de 32 bits ##
sudo dpkg --add-architecture i386

sudo apt update -y
# A linha abaixo é utilizada para distros baseadas no KDE Neon
sudo pkcon update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

sudo apt install curl -y
sudo apt install software-properties-common -y

sudo apt install apt-transport-https -y
sudo apt install build-essential -y
sudo apt install dos2unix -y
sudo apt install ubuntu-restricted-extras -y
sudo apt install vim -y
sudo apt install git git-flow -y
sudo apt install zsh -y
sudo apt install xclip -y

# Definindo zsh como shell padrão
chsh -s $(which zsh)
chsh -s /usr/bin/zsh
sudo usermod -s /usr/bin/zsh $(whoami)
sudo chsh -s /usr/bin/zsh

zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

curl -L -o ~/Downloads/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -L -o ~/Downloads/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -L -o ~/Downloads/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -L -o ~/Downloads/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo mv ~/Downloads/*.ttf /usr/share/fonts/
sudo fc-cache -f -v
fc-cache -f -v

zsh -c 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k'

new_theme='ZSH_THEME="powerlevel10k/powerlevel10k"'

if grep -q "^ZSH_THEME=" ~/.zshrc; then
    sed -i.bak "/^ZSH_THEME=/c\\$new_theme" ~/.zshrc
else
    echo "$new_theme" >> ~/.zshrc
fi

source ~/.zshrc
zsh -c 'source ~/.zshrc'

sudo apt update -y
sudo pkcon update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y && sudo apt full-upgrade && sudo apt autoremove -y && sudo apt autoclean

echo "p10k configure" | xclip -selection clipboard

read -r -p $'\n\n\033[1;34mZsh com oh-my-zsh e powerlevel10k instalados.\nAltere o perfil do terminal para utilizar a fonte \033[31m"MesloLGS NF"\033[0m\033[1;34m.\nLembre-se de executar o comando \033[31m"p10k configure"\033[0m\033[1;34m, ele já está copiado para a área de transferência.\nPressione [Enter] para continuar...\033[0m'

exit;