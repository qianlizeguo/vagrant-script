#!/bin/bash

#http://192.168.33.10:8500/ui

echo ">>> Checking Consul"

if [ ! -f "/usr/local/bin/consul" ]; then
    cd /data/src

    wget -q https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_linux_amd64.zip

    unzip consul_0.7.1_linux_amd64.zip

    mv consul /usr/local/bin/consul
fi

if [ ! -d "/home/vagrant/www" ]; then
    mkdir /home/vagrant/www
    wget https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_web_ui.zip
    unzip consul_0.7.1_web_ui.zip -d /home/vagrant/www/consul
fi

if [ ! -d "/etc/consul.d" ]; then

    sudo mkdir /etc/consul.d

fi

sudo cp -r /data/www/vagrant/templates/consul/etc/* /etc/consul.d

pm2 start /data/www/vagrant/templates/consul/consul.sh

echo ">>> Checking Consul End"
