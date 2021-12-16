#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
    clear
    echo "                       !!! ATENÇÃO !!!"
    echo "              NÃO execute este script como root!"
    echo "              Presione qualquer tecla para sair..."
    read -s -n 1 -p " "
    exit
fi

PASTA_USUARIO=$HOME

## Instalacao XAMPP 5.6 #
if [ ! -d "/opt/lampp/etc" ]; then

    wget https://ufpr.dl.sourceforge.net/project/xampp/XAMPP%20Linux/5.6.40/xampp-linux-x64-5.6.40-1-installer.run
    sudo chmod 755 xampp-linux-x64-5.6.40-1-installer.run
    sudo ./xampp-linux-x64-5.6.40-1-installer.run --mode text --installer-language pt_BR
    sudo rm xampp-linux*
    sudo ln -s /opt/lampp/htdocs/ $PASTA_USUARIO/htdocs
    sudo chmod 777 -R $PASTA_USUARIO/htdocs
    sudo sed -i 's/display_errors=On/display_errors=Off/g' /opt/lampp/etc/php.ini
    sudo sed -i 's/short_open_tag=Off/short_open_tag=On/g' /opt/lampp/etc/php.ini

    rm -f $PASTA_USUARIO/.local/share/applications/XAMPP.desktop
    rm -f $PASTA_USUARIO/Desktop/XAMPP.desktop
    rm -f "$PASTA_USUARIO/Área de Trabalho/XAMPP.desktop"
    sudo rm -f /usr/share/applications/XAMPP.desktop

    cat >"$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" <<EOT
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=XAMPP Control Panel
Comment=Start and Stop XAMPP
Exec=sudo /opt/lampp/manager-linux-x64.run
Icon=/opt/lampp/htdocs/favicon.ico
Categories=Development
Type=Application
Terminal=true
EOT

    chown $USER:$USER -R "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop"
    chmod 755 -R "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop"
    ln -s "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" $PASTA_USUARIO/Desktop/XAMPP.desktop
    ln -s "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" "$PASTA_USUARIO/Área de Trabalho/XAMPP.desktop"
    sudo cp "$PASTA_USUARIO/.local/share/applications/XAMPP.desktop" /usr/share/applications/XAMPP.desktop
    sudo chmod 755 -R /usr/share/applications/XAMPP.desktop

    echo "XAMPP Instalado com sucesso!"

    ## Crinado Link simbólico Mysql #
    sudo ln -s /opt/lampp/bin/mysql /usr/bin/mysql

# sudo /opt/lampp/lampp start
# xdg-open http://localhost

else
    echo "Já exite uma instalação do XAMPP"
fi

read -s -n 1 -p "Pressione alguma tecla para sair..."
exit
