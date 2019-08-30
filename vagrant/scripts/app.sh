#!/bin/bash

#export VAGRANT_PROJECT_ROOT_DIR = /data/www/

# 项目日志目录
if [ ! -d "/data/logs/www" ]; then
    sudo mkdir /data/logs/www
fi

# 新增的其他易用的开发工具
