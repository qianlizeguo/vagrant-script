#!/bin/bash

export XDEBUG_CONFIG="remote_host=$(echo $SSH_CLIENT | awk '{print $1}') idekey=PHPSTORM"
export PHP_IDE_CONFIG="serverName=cli"
