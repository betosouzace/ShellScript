#!/usr/bin/env bash

PASTA_USUARIO=$HOME

## Instalacao XAMPP 5.6 #
# wget https://ufpr.dl.sourceforge.net/project/xampp/XAMPP%20Linux/5.6.40/xampp-linux-x64-5.6.40-1-installer.run
# sudo chmod 755 xampp-linux-x64-5.6.40-1-installer.run
# sudo ./xampp-linux-x64-5.6.40-1-installer.run --mode text --installer-language pt_BR
# sudo rm xampp-linux*
# sudo ln -s /opt/lampp/htdocs/ $HOME/htdocs
# sudo chmod 777 -R $HOME/htdocs
# sudo sed -i 's/display_errors=On/display_errors=Off/g' /opt/lampp/etc/php.ini
# sudo sed -i 's/short_open_tag=Off/short_open_tag=On/g' /opt/lampp/etc/php.ini

echo $PASTA_USUARIO

cat >"$PASTA_USUARIO/XAMPP.desktop" <<EOT
[Desktop Entry]
Name=XAMPP Control Panel
Exec=sudo /opt/lampp/manager-linux-x64.run
Comment=
Terminal=true
Icon=/opt/lampp/htdocs/favicon.ico
Categories=Development;
Type=Application
EOT

# cat >'/usr/share/applications/XAMPP.desktop' <<EOT
# [Desktop Entry]
# Name=XAMPP Control Panel
# Exec=sudo /opt/lampp/manager-linux-x64.run
# Comment=
# Terminal=true
# Icon=/opt/lampp/htdocs/favicon.ico
# Categories=Development;
# Type=Application
# EOT


# rm -f $HOME/mi_app/mi_app.desktop
# rm -f $HOME/.local/share/applications/mi_app.desktop
# rm -f $HOME/Desktop/mi_app.desktop
# rm -f $HOME/Escritorio/mi_app.desktop
# rm -f /usr/share/applications/mi_app.desktop

# chown $USER:$USER -R `echo $HOME`/mi_app/mi_app.desktop

# chmod 755 `echo $HOME`/mi_app/mi_app.desktop

# su - $USER -c "xdg-open 'https://www.mi-app.com/'"

## Crinado Link simbólico Mysql #
# sudo ln -s /opt/lampp/bin/mysql /usr/bin/mysql

# clear
echo "XAMPP Instalado com sucesso!"
read -s -n 1 -p "Pressione Enter para sair..."
exit
