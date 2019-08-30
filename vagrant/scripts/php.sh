#!/bin/bash

echo ">>> Checking PHP"

if [ ! -d "/data/logs/php" ]; then
    sudo mkdir /data/logs/php
fi

if [ ! -f "/data/app/php5.6/bin/php" ]; then

    echo ">>> Installing PHP"

    cd /data/src

    if [ ! -f "php-5.6.25.tar.gz" ]; then
        wget -q http://cn2.php.net/distributions/php-5.6.25.tar.gz
    fi

    if [ ! -d "php-5.6.25" ]; then
        tar -zxf php-5.6.25.tar.gz
    fi

    cd php-5.6.25

    make clean

    sudo ./configure --prefix=/data/app/php5.6 \
    	--with-config-file-path=/data/app/php5.6/lib \
    	--with-config-file-scan-dir=/data/app/php5.6/lib/conf.d \
    	--with-zlib \
    	--with-gettext \
    	--with-curl \
    	--with-gd \
    	--with-freetype-dir \
    	--with-openssl \
    	--with-xmlrpc \
    	--with-pdo-mysql \
    	--enable-ftp \
    	--enable-exif \
    	--enable-shmop \
    	--enable-sysvmsg \
    	--enable-sysvsem \
    	--enable-sysvshm \
    	--enable-xml \
    	--enable-bcmath \
    	--enable-mbregex \
    	--enable-mbstring \
    	--enable-pcntl \
    	--enable-sockets \
    	--enable-zip \
    	--enable-soap \
    	--enable-pdo \
    	--enable-fpm

    make && make install

    cp php.ini-development /data/app/php5.6/lib/php.ini

    cp /data/app/php5.6/etc/php-fpm.conf.default /data/app/php5.6/etc/php-fpm.conf
	cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
	chmod +x /etc/init.d/php-fpm

	sudo sed -i "s/display_errors = .*/display_errors = On/" /data/app/php5.6/lib/php.ini
	sudo sed -i "s|;date.timezone =|date.timezone = \"Asia/Shanghai\"|g" /data/app/php5.6/lib/php.ini
	sudo sed -i "s/;error_log = php_errors.log/error_log = \/data\/logs\/php\/errors.log/" /data/app/php5.6/lib/php.ini

	# fpm配置
	sudo sed -i "s/;request_slowlog_timeout = 0/request_slowlog_timeout = 5/" /data/app/php5.6/etc/php-fpm.conf
	sudo sed -i "s/;slowlog = .*/slowlog = \/data\/logs\/php\/\$pool.log.slow/" /data/app/php5.6/etc/php-fpm.conf
	sudo sed -i "s/user = nobody/user = www/" /data/app/php5.6/etc/php-fpm.conf
	sudo sed -i "s/group = nobody/group = www/" /data/app/php5.6/etc/php-fpm.conf

	ln -s /data/app/php5.6/bin/pear /usr/local/bin/pear
	ln -s /data/app/php5.6/bin/peardev /usr/local/bin/peardev
	ln -s /data/app/php5.6/bin/pecl /usr/local/bin/pecl
	ln -s /data/app/php5.6/bin/phar /usr/local/bin/phar
	ln -s /data/app/php5.6/bin/phar.phar /usr/local/bin/phar.phar
	ln -s /data/app/php5.6/bin/php /usr/local/bin/php
	ln -s /data/app/php5.6/bin/php-cgi /usr/local/bin/php-cgi
	ln -s /data/app/php5.6/bin/php-config /usr/local/bin/php-config
	ln -s /data/app/php5.6/bin/phpize /usr/local/bin/phpize

	# user vagrant & root
	# vagrant ssh是以vagrant用户
	#sudo ln -s /data/app/php5.6/bin/phpize /bin/phpize
	#sudo ln -s /data/app/php5.6/bin/php /bin/php
	#sudo ln -s /data/app/php5.6/bin/php-cgi /bin/php-cgi
	#sudo ln -s /data/app/php5.6/bin/php-config /bin/php-config

    sudo ln -s /data/app/php5.6/bin/phpize /bin/phpize
    sudo ln -s /data/app/php5.6/bin/php /bin/php
    sudo ln -s /data/app/php5.6/bin/php-cgi /bin/php-cgi
    sudo ln -s /data/app/php5.6/bin/php-config /bin/php-config

    echo ">>> Installing PHP Success"
fi

if [ ! -d "/data/app/php5.6/lib/conf.d" ]; then
    sudo mkdir /data/app/php5.6/lib/conf.d
fi

# TODO 判断升级

# phalcon扩展
echo ">>> Checking Phalcon Extension"
cd /data/src
if [ ! -f "phalcon-v2.0.13.zip" ]; then
    wget -q https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.zip
fi

if [ ! -d "cphalcon-phalcon-v2.0.13" ]; then
    unzip -q phalcon-v2.0.13.zip

    cd cphalcon-phalcon-v2.0.13/build
    sudo ./install
    echo "extension=phalcon.so" > /data/app/php5.6/lib/conf.d/ext-phalcon.ini
fi

# phalcon3扩展
#echo ">>> Checking Phalcon3 Extension"
#cd /data/src
#if [ ! -f "v3.0.1.zip" ]; then
#    wget https://github.com/phalcon/cphalcon/archive/v3.0.1.zip
#fi
#
#if [ ! -d "cphalcon-3.0.1" ]; then
#    unzip -q v3.0.1.zip
#
#    cd cphalcon-3.0.1/build
#    sudo ./install
#    echo "extension=phalcon.so" > /data/app/php5.6/lib/conf.d/ext-phalcon.ini
#fi

# swoole扩展
echo ">>> Checking Swoole Extension"
cd /data/src

if [ ! -f "swoole-1.8.5-stable.tar.gz" ]; then
    wget -q https://github.com/swoole/swoole-src/archive/swoole-1.8.5-stable.tar.gz

fi

if [ ! -d "swoole-src-swoole-1.8.5-stable" ]; then
    tar -zxf swoole-1.8.5-stable.tar.gz

    cd swoole-src-swoole-1.8.5-stable
    phpize && ./configure && make && make install
    echo -e "extension=swoole.so\nswoole.use_namespace=On" > /data/app/php5.6/lib/conf.d/ext-swoole.ini
fi


# redis扩展
echo ">>> Checking Redis Extension"
cd /data/src
if [ ! -f "2.2.8.tar.gz" ]; then
    wget -q https://github.com/phpredis/phpredis/archive/2.2.8.tar.gz
fi

if [ ! -d "phpredis-2.2.8" ]; then
    tar -zxf 2.2.8.tar.gz

    cd phpredis-2.2.8
    phpize && ./configure && make && make install
    echo -e "extension=redis.so" > /data/app/php5.6/lib/conf.d/ext-redis.ini
fi

# xdebug扩展
echo ">>> Checking Xdebug Extension"
cd /data/src
if [ ! -d "xdebug" ]; then
    git clone git://github.com/xdebug/xdebug.git

    cd xdebug
    phpize && ./configure && make && make install
    echo -e "zend_extension=xdebug.so" > /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_enable=1" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_host=$(echo $SSH_CLIENT | awk '{print $1}')" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_port=9000" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.max_nesting_level=200" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.idekey=\"PHPSTORM\"" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_autostart=1" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
fi

if [ $(grep -c "" /data/app/php5.6/lib/conf.d/ext-xdebug.ini) != 7 ]; then
    echo -e "zend_extension=xdebug.so" > /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_enable=1" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_host=$(echo $SSH_CLIENT | awk '{print $1}')" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_port=9000" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.max_nesting_level=200" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.idekey=\"PHPSTORM\"" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
    echo -e "xdebug.remote_autostart=1" >> /data/app/php5.6/lib/conf.d/ext-xdebug.ini
fi

cp /data/www/vagrant/templates/xdebug.sh /etc/profile.d
source /etc/profile

# beehive扩展
echo ">>> Checking Beehive Extension"
cd /data/src
if [ ! -d "beehive-php-ext" ]; then
    git clone https://github.com/shouyintv/beehive-php-ext.git

    cd beehive-php-ext
    phpize && ./configure && make && make install
    echo -e "extension=beehive.so" > /data/app/php5.6/lib/conf.d/ext-beehive.ini
fi

# memcached扩展
echo ">>> Checking Libmemcached"
cd /data/src
if [ ! -f "libmemcached-1.0.18.tar.gz" ]; then
    wget -q https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz
fi

if [ ! -d "libmemcached-1.0.18" ]; then
    tar -zxf libmemcached-1.0.18.tar.gz

    cd libmemcached-1.0.18
    ./configure && make && make install
fi

echo ">>> Checking Memcached Extension"
cd /data/src
if [ ! -f "memcached-2.2.0.tgz" ]; then
    wget -q https://pecl.php.net/get/memcached-2.2.0.tgz
fi

if [ ! -d "memcached-2.2.0" ]; then
    tar -zxf memcached-2.2.0.tgz

    cd memcached-2.2.0
    phpize && ./configure && make && make install
    echo -e "extension=memcached.so" > /data/app/php5.6/lib/conf.d/ext-memcached.ini
fi

echo ">>> Checking PHP End"
