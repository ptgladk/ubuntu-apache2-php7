#!/bin/bash

# Repositories
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:nijel/phpmyadmin
apt-get update

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-user string root'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'

# apache, php, mysql, phpmyadmin
apt-get install -y apache2
apt-get install -y php7.1
apt-get install -y mysql-server
apt-get install -y phpmyadmin

rm -rf /var/www
ln -s /vagrant /var/www

apt-get install -y mc
apt-get install -y curl
apt-get install -y git

# php extensions
apt-get install -y php7.1-common php7.1-mysql php7.1-mcrypt php7.1-cli php7.1-curl

# Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# PHPUnit
wget https://phar.phpunit.de/phpunit-6.1.phar
chmod +x phpunit-6.1.phar
mv phpunit-6.1.phar /usr/local/bin/phpunit

