#!/bin/bash

## 基础配置
export SY_CONTAINER_TOKEN=abcd
export SY_CONTAINER_SIGNATURE=abcd
export SY_CONTAINER_HOST=192.168.1.236
export SY_CONTAINER_PORT=9600

## 网关相关
export SY_GATEWAY_PORT=8888
export SY_WS_PORT=8899
export SY_ROBOT_PORT=8891

## PHP-FPM
export SY_APPLICATION_ENV=local
export SY_RPC_HOST=192.168.1.236
export SY_RPC_PORT=9581

##TMP
export SY_LOGPATH=/data/logs/
export SY_TMP_PATH=/data/tmp/

## RDS
export SY_DB_CONIFG='mysql:dbname=db_config;host=192.168.1.234;port=3306;'
export SY_DB_CONIFG_USER_NAME=root
export SY_DB_CONIFG_USER_PASSWORD=123456

export SY_DB_LIVE='mysql:dbname=db_live;host=192.168.1.234;port=3306;'
export SY_DB_LIVE_USER_NAME=root
export SY_DB_LIVE_USER_PASSWORD=123456

export SY_DB_LOG='mysql:dbname=db_log;host=192.168.1.234;port=3306;'
export SY_DB_LOG_USER_NAME=root
export SY_DB_LOG_USER_PASSWORD=123456

export SY_DB_USER='mysql:dbname=db_user;host=192.168.1.234;port=3306;'
export SY_DB_USER_USER_NAME=root
export SY_DB_USER_USER_PASSWORD=123456

export SY_DB_RICH='mysql:dbname=db_rich;host=192.168.1.234;port=3306;'
export SY_DB_RICH_USER_NAME=root
export SY_DB_RICH_USER_PASSWORD=123456

export SY_DB_NAVY='mysql:dbname=db_navy;host=192.168.1.234;port=3306;'
export SY_DB_NAVY_USER_NAME=root
export SY_DB_NAVY_USER_PASSWORD=123456

export SY_DB_DASHBOARD='mysql:dbname=db_dashboard;host=192.168.1.234;port=3306;'
export SY_DB_DASHBOARD_USER_NAME=root
export SY_DB_DASHBOARD_USER_PASSWORD=123456

export SY_DB_ACTIVE='mysql:dbname=db_active;host=192.168.1.234;port=3306;'
export SY_DB_ACTIVE_USER_NAME=root
export SY_DB_ACTIVE_USER_PASSWORD=123456

## REDIS
export SY_REDIS_USER_HOST_PROXY=192.168.1.234
export SY_REDIS_USER_HOST=192.168.1.234
export SY_REDIS_USER_PORT=6379
export SY_REDIS_USER_AUTH=''

export SY_REDIS_STORAGE_HOST_PROXY=192.168.1.234
export SY_REDIS_STORAGE_HOST=192.168.1.234
export SY_REDIS_STORAGE_PORT=6379
export SY_REDIS_STORAGE_AUTH=''

export SY_REDIS_CACHE_HOST_PROXY=192.168.1.234
export SY_REDIS_CACHE_HOST=192.168.1.234
export SY_REDIS_CACHE_PORT=6379
export SY_REDIS_CACHE_AUTH=''

export SY_REDIS_SESSION_HOST_PROXY=192.168.1.234
export SY_REDIS_SESSION_HOST=192.168.1.234
export SY_REDIS_SESSION_PORT=6379
export SY_REDIS_SESSION_AUTH=''
