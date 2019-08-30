#!/bin/bash

echo ">>> Checking Nginx"

if [ ! -f "/data/app/nginx/sbin/nginx" ]; then

    echo ">>> Installing Nginx"

    cd /data/src

    if [ ! -f "nginx-1.10.1.tar.gz" ]; then
        wget -q http://nginx.org/download/nginx-1.10.1.tar.gz
    fi

    if [ ! -d "nginx-1.10.1" ]; then
        tar -zxf nginx-1.10.1.tar.gz
    fi

    cd nginx-1.10.1

    make clean

    sudo ./configure --prefix=/data/app/nginx \
        --sbin-path=/data/app/nginx/sbin/nginx \
        --conf-path=/data/app/nginx/conf/nginx.conf \
        --error-log-path=/data/logs/nginx/error.log \
        --http-log-path=/data/logs/nginx/access.log \
        --pid-path=/data/app/nginx/logs/nginx.pid \
        --lock-path=/data/app/nginx/logs/nginx.lock \
        --http-client-body-temp-path=/data/app/nginx/client_body_temp \
        --http-proxy-temp-path=/data/app/nginx/proxy_temp \
        --http-fastcgi-temp-path=/data/app/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/data/app/nginx/uwsgi_temp \
        --http-scgi-temp-path=/data/app/nginx/scgi_temp \
        --user=www \
        --group=www \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_auth_request_module \
        --with-threads \
        --with-stream \
        --with-stream_ssl_module \
        --with-http_slice_module \
        --with-mail \
        --with-mail_ssl_module  \
        --with-file-aio \
        --with-http_v2_module \
        --with-ipv6

    make

    make install

    sudo /usr/sbin/groupadd -f www
    sudo /usr/sbin/useradd -g www www

    echo ">>> Installing Nginx Success"

fi

echo ">>> Copy Nginx Config File"

cp -r /data/www/vagrant/templates/nginx/vhost /data/app/nginx/conf
cp /data/www/vagrant/templates/nginx/nginx.conf /data/app/nginx/conf
cp /data/www/vagrant/templates/nginx/control.conf /data/app/nginx/conf

echo ">>> Checking Nginx End"