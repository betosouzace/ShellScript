#!/usr/bin/env bash

# ## Adicionando/Confirmando arquitetura de 32 bits ##
# sudo dpkg --add-architecture i386

# sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoclean && sudo apt autoremove -y

# sudo apt install curl -y
# sudo apt install software-properties-common -y
# sudo apt install apt-transport-https -y
# sudo apt-get install ca-certificates wget curl lsb-release -y
# sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common gnupg2 -y
# sudo apt install build-essential -y
# sudo apt install dos2unix -y
# sudo apt install p7zip-rar p7zip-full lzma lzma-dev rar unrar-free p7zip ark ncompress -y
# sudo apt install network-manager-openvpn -y
# sudo apt install neovim -y
# sudo apt install clang -y
# sudo apt install cmake -y
# sudo apt install wget -y
# sudo apt install git git-flow -y
# sudo apt install zsh -y
# sudo apt install net-tools -y
# sudo apt install samba -y
# sudo apt install xrdp -y
# sudo apt install gcc -y
# sudo apt install g++ -y
# sudo apt install make -y
# sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev

# # instalação PHP
# sudo add-apt-repository ppa:ondrej/php -y
# sudo add-apt-repository ppa:ondrej/apache2 -y
# sudo apt update
# desisntalação PHP 8.2 para instalação do PHP 8.1
sudo apt purge php8.1 php8.1-common php8.1-cli php8.1-fpm php8.1-json php8.1-opcache php8.1-readline php8.1-mysql php8.1-mbstring php8.1-xml php8.1-zip php8.1-curl php8.1-gd php8.1-imagick php8.1-intl php8.1-bcmath php8.1-ldap php8.1-imap php8.1-soap php8.1-xmlrpc php8.1-sqlite3 php8.1-pgsql php8.1-dev php8.1-mcrypt php8.1-sqlite3 php8.1-dom php8.1-bcmath php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl php8.1-cgi php8.1-pgsql php8.1-ldap -y

sudo apt install openssl mcrypt php8.0 php8.0-mcrypt php8.0-common php8.0-mysql php8.0-sqlite3 php8.0-dom php8.0-bcmath php8.0-xml php8.0-xmlrpc php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-dev php8.0-imap php8.0-mbstring php8.0-opcache php8.0-soap php8.0-zip php8.0-intl php8.0-cgi php8.0-pgsql php8.0-ldap -y
sudo apt install php8.0-{mcrypt,common,mysql,sqlite3,dom,bcmath,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl,cgi,pgsql,ldap} -y
sudo apt install php8.0 php8.0-mysql php8.0-sqlite3 php8.0-dom php8.0-bcmath php8.0-xml php8.0-xmlrpc php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-dev php8.0-imap php8.0-mbstring php8.0-opcache php8.0-soap php8.0-zip php8.0-intl php8.0-cgi php8.0-pgsql php8.0-ldap -y

# # Definindo zsh como shell padrão
# chsh -s $(which zsh)
# chsh -s /usr/bin/zsh
# sudo usermod -s /usr/bin/zsh $(whoami)
# chsh -s /bin/zsh
# sudo chsh -s /bin/zsh

## Instalacao Composer #
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
composer self-update

# configuração do apache
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod ssl

# libera as portas 80 e 443
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
# libera a porta 3306
sudo ufw allow 3306/tcp
# libera portas de envio e recebimento de e-mail
sudo ufw allow 25/tcp
sudo ufw allow 465/tcp
sudo ufw allow 587/tcp
# libera a porta 22
sudo ufw allow 22/tcp
# libera a porta 5900 para o vnc
sudo ufw allow 5900/tcp
# libera a porta 3389 para o rdp
sudo ufw allow 3389/tcp
# libera porta para ftp
sudo ufw allow 21/tcp
# Libera as conexões http e https
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 'Apache Full'
sudo ufw delete allow 'Apache'

# seta o timezone para America/Sao_Paulo
sudo timedatectl set-timezone America/Sao_Paulo

# instala e configura o apache
sudo apt install apache2 -y
sudo apt install libapache2-mod-php8.0 -y
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2

# instala e configura o mariadb
sudo apt install mariadb-server mariadb-client -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo systemctl status mariadb

# configura o acesso remoto ao mariadb
sudo sed -i 's/bind-address/#bind-address/g' /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb

# configura o domínio
sudo apt install certbot python3-certbot-apache -y
echo "Informe o nome do dominio para o certificado SSL"
read dominio

# configura os subdominios do apache
# configuração do subdominio blog.$dominio
sudo mkdir -p /var/www/blog
sudo echo "<VirtualHost *:80>
    ServerName blog.$dominio
    ServerAlias www.blog.$dominio
    Redirect permanent / https://blog.$dominio/
    DocumentRoot /var/www/blog
    <Directory /var/www/blog>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/blog.$dominio-error.log
    CustomLog ${APACHE_LOG_DIR}/blog.$dominio-access.log combined
</VirtualHost>" > /etc/apache2/sites-available/blog.$dominio.conf

# configuração do subdominio app.$dominio que utiliza o laravel
sudo mkdir -p /var/www/app
sudo echo "<VirtualHost *:80>
    ServerName app.$dominio
    ServerAlias www.app.$dominio
    Redirect permanent / https://app.$dominio/
    DocumentRoot /var/www/app/public
    <Directory /var/www/app/public>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/app.$dominio-error.log
    CustomLog ${APACHE_LOG_DIR}/app.$dominio-access.log combined
</VirtualHost>" > /etc/apache2/sites-available/app.$dominio.conf

# configuração do dominio principal
sudo echo "<VirtualHost *:80>
    ServerName $dominio
    ServerAlias www.$dominio
    Redirect permanent / https://$dominio/
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/$dominio-error.log
    CustomLog ${APACHE_LOG_DIR}/$dominio-access.log combined
</VirtualHost>" > /etc/apache2/sites-available/$dominio.conf

# configura o apache para o subdominio blog.$dominio
sudo a2ensite blog.$dominio.conf
sudo systemctl reload apache2

# configura o apache para o subdominio app.$dominio
sudo a2ensite app.$dominio.conf
sudo systemctl reload apache2

# configura o apache para o dominio principal
sudo a2ensite $dominio.conf
sudo systemctl reload apache2

# configura a inicialização do php e do apache junto com o sistema
sudo systemctl enable apache2
sudo systemctl enable php8.0-fpm


# configura o acesso ftp a pasta /var/www/html para o usuario root e o grupo root
sudo chown -R root:root /var/www/html
sudo chmod -R 755 /var/www/html

# configura o acesso ftp a pasta /var/www/app para o usuario root e o grupo root
sudo chown -R root:root /var/www/app
sudo chmod -R 755 /var/www/app

#  baixa o repositório do laravel para a pasta /var/www/app de https://github.com/betosouzace/ultimate.git
sudo git clone https://github.com/betosouzace/ultimate.git /var/www/app
sudo chown -R root:root /var/www/app
sudo chmod -R 755 /var/www/app

# # cria o certificado gratuito para o apache com o certbot para o dominio informado
# sudo certbot --apache -d $dominio -d www.$dominio -d blog.$dominio -d app.$dominio
# # renova o certificado SSL
# sudo certbot renew --dry-run

# reinicia o sistema
sudo reboot


# configura o keycloak no apache no subdominio auth.$dominio
sudo apt install libapache2-mod-auth-openidc -y
sudo echo "<VirtualHost *:80>
    ServerName auth.$dominio
    ServerAlias www.auth.$dominio
    DocumentRoot /var/www/auth
    <Directory /var/www/auth>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/auth.$dominio-error.log
    CustomLog ${APACHE_LOG_DIR}/auth.$dominio-access.log combined
</VirtualHost>" > /etc/apache2/sites-available/auth.$dominio.conf

# configura o apache para o subdominio auth.$dominio
sudo a2ensite auth.$dominio.conf
sudo systemctl reload apache2

# configura o apache para o subdominio blog.$dominio
sudo a2ensite blog.$dominio.conf
sudo systemctl reload apache2

# configura o apache para o subdominio app.$dominio
sudo a2ensite app.$dominio.conf
sudo systemctl reload apache2

# configura o apache para o dominio principal
sudo a2ensite $dominio.conf
sudo systemctl reload apache2

sudo reboot

# termina a execução do script
exit

# instalação keycloak
sudo mkdir -p /usr/lib/jvm
sudo wget https://download.java.net/java/GA/jdk20.0.2/6e380f22cbe7469fa75fb448bd903d8e/9/GPL/openjdk-20.0.2_linux-x64_bin.tar.gz -P /usr/lib/jvm
sudo tar -xvzf /usr/lib/jvm/openjdk-20.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm
sudo rm /usr/lib/jvm/openjdk-20.0.2_linux-x64_bin.tar.gz
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-20.0.2/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-20.0.2/bin/javac 1
sudo update-alternatives --install /usr/bin/jar jar /usr/lib/jvm/jdk-20.0.2/bin/jar 1
sudo update-alternatives --set java /usr/lib/jvm/jdk-20.0.2/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/jdk-20.0.2/bin/javac
sudo update-alternatives --set jar /usr/lib/jvm/jdk-20.0.2/bin/jar
sudo echo "JAVA_HOME=/usr/lib/jvm/jdk-20.0.2" >> /etc/environment
sudo echo "JRE_HOME=/usr/lib/jvm/jdk-20.0.2/jre" >> /etc/environment
sudo echo "PATH=$PATH:$HOME/bin:$JAVA_HOME/bin" >> /etc/environment
sudo echo "export JAVA_HOME" >> /etc/environment
sudo echo "export JRE_HOME" >> /etc/environment
sudo echo "export PATH" >> /etc/environment
source /etc/environment

sudo mkdir -p /opt/keycloak
sudo wget https://github.com/keycloak/keycloak/releases/download/22.0.1/keycloak-22.0.1.zip -P /opt/keycloak
sudo unzip /opt/keycloak/keycloak-22.0.1.zip -d /opt/keycloak
sudo rm /opt/keycloak/keycloak-22.0.1.zip
sudo chmod +x /opt/keycloak/keycloak-22.0.1/bin/kc.sh
# adiciona o comando 'bin/kc.sh start' para iniciar o keycloak na inicialização do sistema
sudo echo "[Unit]
Description=Keycloak
After=network.target

[Service]
Type=simple
User=root
Group=root
ExecStart=/opt/keycloak/keycloak-22.0.1/bin/kc.sh start
ExecStop=/opt/keycloak/keycloak-22.0.1/bin/kc.sh stop
TimeoutStartSec=5
TimeoutStopSec=5
Restart=on-failure

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/keycloak.service

sudo systemctl daemon-reload
sudo systemctl enable keycloak.service
sudo systemctl start keycloak.service
sudo systemctl status keycloak.service

# configura o keycloak no apache no subdominio auth.$dominio, por padrão o keycloak utiliza a porta 8080, mas invés de utilizar a porta 8080, vamos redirecionar para a porta 80 no subdominio auth.$dominio para facilitar o acesso
sudo apt install libapache2-mod-proxy-html libxml2-dev -y
sudo a2enmod proxy
sudo a2enmod proxy_html
sudo a2enmod proxy_http
sudo a2enmod headers
sudo a2enmod xml2enc
sudo echo "<VirtualHost *:80>
    ServerName auth.$dominio
    ServerAlias www.auth.$dominio
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/
    ErrorLog ${APACHE_LOG_DIR}/auth.$dominio-error.log
    CustomLog ${APACHE_LOG_DIR}/auth.$dominio-access.log combined
</VirtualHost>" > /etc/apache2/sites-available/auth.$dominio.conf

# configura o apache para o subdominio auth.$dominio
sudo a2ensite auth.$dominio.conf
sudo systemctl reload apache2