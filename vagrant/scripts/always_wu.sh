#!/bin/bash

sudo service php-fpm start

sudo /data/app/nginx/sbin/nginx

cp /app/data/vagrant/templates/config.sh /etc/profile.d
source /etc/profile

# 项目可写文件夹设置
if [ -d "/data/www/app_h5/website/runtime/" ]; then

    #sudo chmod 777 -R /data/www/app_h5/website/runtime/

fi
