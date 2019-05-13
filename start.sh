#!/bin/bash

echo ">>> 开始启动docker.service "

service docker start

echo ">>> 开始启动gitlab "
docker run -d  -p 2222:22 \
               -p 8081:80 \
               -p 8443:443 \
               -v /docker/gitlab/config:/etc/gitlab \
               -v /docker/gitlab/logs:/var/log/gitlab \
               -v /docker/gitlab/data:/var/opt/gitlab \
               --privileged=true \
               --name gitlab  \
               gitlab/gitlab-ce

