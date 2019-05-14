#!/bin/bash

echo ">>> 开始启动docker.service "

service docker start

echo ">>> 开始启动gitlab "
docker rm gitlab
docker run -d  -p 8222:22 \
               -p 8081:80 \
               -p 8443:443 \
               -v /docker/gitlab/config:/etc/gitlab \
               -v /docker/gitlab/logs:/var/log/gitlab \
               -v /docker/gitlab/data:/var/opt/gitlab \
               --privileged=true \
               --name gitlab  \
               gitlab/gitlab-ce

echo ">>>>  启动mysql"
docker rm mysql
docker run --name mysql -d --rm \
            -v /docker/mysql/conf:/etc/mysql/conf.d \
            -v /docker/mysql/data:/var/lib/mysql \
            --privileged=true \
            -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql

echo ">>>> 启动redis"
docker rm redis
docker run --name redis -d \
            -p 6379:6379 \
            -v /docker/redis/data:/data \
            --privileged=true redis \
            redis-server --appendonly yes
