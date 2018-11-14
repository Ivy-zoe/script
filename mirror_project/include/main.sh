#!/bin/bash

# Env
WORK_DIR=/opt/soft/mirror_project
Config_DIR=/opt/soft/mirror_project/config
DATA_DIR=/data/mirrors
EPEL6=$DATA_DIR/epel/6
EPEL7=$DATA_DIR/epel/7
CentOS7=$DATA_DIR/centos/7
CentOS6=$DATA_DIR/centos/6
MONGODB=$DATA_DIR/mongodb/6
Mariadb=$DATA_DIR/mariadb/7
Nginx=$DATA_DIR/nginx/6
REMI=$DATA_DIR/remi/6
ZABBIX6=$DATA_DIR/zabbix/6
ZABBIX7=$DATA_DIR/zabbix/7
GLIBC=$DATA_DIR/glibc/6
influxdata7=$DATA_DIR/influxdata/7
influxdata6=$DATA_DIR/influxdata/6
MYSQL57=$DATA_DIR/mysql57/7
PMM=$DATA_DIR/pmm/6
TUNA=mirrors.tuna.tsinghua.edu.cn
USTC=mirrors.ustc.edu.cn
ROCK=$DATA_DIR/rock
DOCKER=$DATA_DIR/docker

REDSLEVE=http://ftp.redsleeve.org/pub/steam/
NGINX=http://nginx.org/packages/centos/6/x86_64/RPMS/


# clover
function blackcolor {
    echo -e "\033[32m$1\033[0m"
}
function redcolor {
    echo -e "\033[31m$1\033[0m"
}
function greencolor {
    echo -e "\033[32m$1\033[0m"
}
function bluecolor {
    echo -e "\033[34m$1\033[0m"
}
function purplecolor {
    echo -e "\033[35m$1\033[0m"
}
function skybluecolor {
    echo -e "\033[36m$1\033[0m"
}
function skybluecolor {
    echo -e "\033[37m$1\033[0m"
}


