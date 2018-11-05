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



function Check_Software(){
    type rsync >/dev/null 2>&1 || { redcolor >&2 "I require rsync but it's not installed.  Aborting."; yum install rsync -y; }
    type createrepo >/dev/null 2>&1 || { redcolor >&2 "I require createrepo but it's not installed.  Aborting."; yum install createrepo -y; }
    type curl >/dev/null 2>&1 || { redcolor >&2 "I require curl but it's not installd . Aborting."; yum install curl -y;}
}
# check dir

function Check_Mirrors_Dirs(){
    if [ -d $WORK_DIR ];then
        greencolor "$WORK_DIR is OK"
    else
        mkdir -p $WORK_DIR
    fi


    if [ -d $DATA_DIR ]; then
        greencolor "$DATA_DIR is OK!"
    else
        mkdir -p $DATA_DIR
    fi


    if [ -d $CentOS6 ]; then
        greencolor "$CentOS6 is OK!"
    else
        mkdir -p $CentOS6
    fi

    if [ -d $CentOS7 ]; then
        greencolor "$CentOS7 is OK!"
    else
        mkdir -p $CentOS7
    fi


    if [ -d $EPEL7 ]; then
        greencolor "$EPEL7 is OK!"
    else
        mkdir -p $EPEL7
    fi

    if [ -d $EPEL6 ]; then
        greencolor "$EPEL6 is OK!"
    else
        mkdir -p $EPEL6
    fi

    if [ -d $Mariadb ]; then
        greencolor "$Mariadb is OK!"
    else
        mkdir -p $Mariadb
    fi

    if [ -d $Nginx ]; then
        greencolor "$Nginx is OK!"
    else
        mkdir -p $Nginx
    fi

    if [ -d $GLIBC ]; then
        greencolor "GLIBC is OK!"
    else
        mkdir -p $GLIBC
    fi

    if [ -d $ZABBIX6/deprecated ]; then
        greencolor "$ZABBIX6/deprecated is OK!"
    else
        mkdir -p $ZABBIX6/deprecated
    fi

    if [ -d $MONGODB ]; then
        greencolor "$MONGODB is OK!"
    else
        mkdir -p $MONGODB
    fi

    if [ -d $ZABBIX6/SRPMS ]; then
        greencolor "$ZABBIX6/SRPMS is OK!"
    else
        mkdir -p $ZABBIX6/SRPMS
    fi

    if [ -d $ZABBIX6/non-supported/SRPMS ]; then
        greencolor "$ZABBIX6/non-supported/SRPMS is OK!"
    else
        mkdir -p $ZABBIX6/non-supported/SRPMS
    fi

    if  [ -d $ZABBIX7/non-supported/SRPMS ]; then
        greencolor "$ZABBIX7/non-supported/SRPMS is OK!"
    else
        mkdir -p $ZABBIX7/non-supported/SRPMS
    fi


    if [ -d $ZABBIX7/SRPMS ]; then
        greencolor "$ZABBIX7/SRPMS is OK!"
    else
        mkdir -p $ZABBIX7/SRPMS
    fi

    if [ -d $REMI/php72 ]; then
        greencolor "$REMI/php72 is OK!"
    else
        mkdir -p $REMI/php72
    fi

    if [ -d $REMI/php56 ]; then
        greencolor "$REMI/php56 is OK!"
    else
        mkdir -p $REMI/php56
    fi

    if [ -d $influxdata6 ]; then
        greencolor "$influxdata6 is OK!"
    else
        mkdir -p $influxdata6
    fi

    if [ -d $influxdata7 ]; then
        greencolor "$influxdata7 is OK!"
    else
        mkdir -p $influxdata7
    fi

    if [ -d $MYSQL57 ]; then
        greencolor "$MYSQL57 is OK!"
    else
        mkdir -p "$MYSQL57"
    fi

    if [ -d $PMM ]; then
        greencolor "$PMM is OK!"
    else
        mkdir -p "$PMM"
    fi

    if [ -d $ROCK ]; then
        greencolor "$ROCK is OK!"
    else
        mkdir -p $ROCK
    fi

    if [ -d $DOCKER ]; then
        greencolor "$DOCKER is OK!"
    else
        mkdir -p $DOCKER
    fi


}




function Updata_Config(){
    cp -r ./config $WORK_DIR

}



function all(){
    Rsync_CentOS6
    Rsync_CentOS7
    Rsync_epel6
    Rsync_epel7
}
