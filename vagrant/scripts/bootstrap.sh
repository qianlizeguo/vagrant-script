#!/bin/bash

# 创建项目文件夹
if [ ! -d "/data" ]; then
    mkdir /data
fi

# 下载软件目录
if [ ! -d "/data/src" ]; then
    mkdir /data/src
fi

# libtool
yum -y install pcre pcre-devel zlib zlib-devel openssl openssl-devel libxml2 libxml2-devel libcurl libcurl-devel \
		libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libtool git gcc-c++

cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
