#!/bin/bash
consul agent -dev -data-dir=/home/vagrant/data/consul -client 0.0.0.0 -ui -config-dir /etc/consul.d