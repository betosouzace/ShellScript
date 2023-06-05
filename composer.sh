#!/usr/bin/env bash

# mensagem de inicio
echo " "
echo "Atualizando o sistema..."
echo " "

## Instalacao Composer #
echo " "
echo "Instalando o Composer..."
echo " "
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

echo " "
echo "Atualizações concluídas"
read -s -n 1 -p "Pressione Enter para sair..."
exit
