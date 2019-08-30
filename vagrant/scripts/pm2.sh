#!/bin/bash

if [ ! -f "/usr/bin/npm" ]; then

    sudo curl -sL https://rpm.nodesource.com/setup_6.x | bash -

    #sudo yum erase -y nodejs
    sudo yum install -y nodejs

fi

if [ ! -f "/usr/bin/pm2" ]; then

    sudo npm install pm2@latest -g

fi