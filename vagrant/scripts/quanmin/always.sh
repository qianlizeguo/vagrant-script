#!/bin/bash

sudo rm -fr /etc/profile.d/config.sh
sudo rm -fr /etc/profile.d/app.sh
cp /data/www/vagrant/templates/profile/quanmin_config.sh /etc/profile.d

source /etc/profile

cp /data/www/vagrant/templates/profile/quanmin/www.quanmin.tv.outer /data/app/nginx/conf/vhost
cp /data/www/vagrant/templates/profile/quanmin/api.quanmin.tv.outer /data/app/nginx/conf/vhost

#sudo chmod 777 -R /data/www/quanmin/frontend/protected/runtime/

sudo mkdir -p /app/local/log/business

sudo chmod 777 -R /app/local/log/business

#sudo touch open_log
