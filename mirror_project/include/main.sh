#!/bin/bash


# env config

Config_DIR=./config
DATA_DIR=/data/chaos/mirrors
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

# check dir

function Check_directory(){

    _check_directory $DATE_DIR
    _check_directory $EPEL6
    _check_directory $EPEL7
    _check_directory $CentOS6
    _check_directory $CentOS7
    _check_directory $CentOS7/os/x86_64
    _check_directory $CentOS7/updates/x86_64/
    _check_directory $CentOS7/extras/x86_64/
    _check_directory $CentOS7/centosplus/x86_64/
    _check_directory $MONGODB
    _check_directory $Mariadb
    _check_directory $Nginx
    _check_directory $REMI
    _check_directory $ZABBIX7
    _check_directory $GLIBC
    _check_directory $influxdata6
    _check_directory $influxdata7
    _check_directory $MYSQL57
}



# url
glibc_url=http://ftp.redsleeve.org/pub/steam/
NGINX=http://nginx.org/packages/centos/6/x86_64/RPMS/
rsync_tuna=rsync://mirrors.tuna.tsinghua.edu.cn
USTC=mirrors.ustc.edu.cn

function _check_path(){

    _check_command_and_yum_install git
    _check_command_and_yum_install install rsync
#    _check_command_and_yum_install install createrepo
}

#!/bin/bash

function List(){
    clear
    echo "+---------------------------------------------------------------------------------------+"
    echo "| Number  images_command    Website                      Local_Path           "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 1       epel6         $TUNA        $EPEL6   "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 2       epel7         $TUNA        $EPEL7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 3       centos7       $TUNA        $CentOS7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 4       centos6       $TUNA        $CentOS6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 5       mariadb   $TUNA        $Mariadb"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 6       remi           $TUNA       $REMI"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 7       mongodb     $TUNA        $MONGODB"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 8       zabbix6       $TUNA        $ZABBIX6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 9      zabbix7       $TUNA         $ZABBIX7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "|                 Curl "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 10      glibc        $REDSLEVE         $GLIBC"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 11       nginx         $USTC        $Nginx "
    echo "+---------------------------------------------------------------------------------------+"
}

function RUN(){
    clear
    echo "+------------------------------------------------------------------------+"
    echo "|                   Rsync Script          "
    echo "+------------------------------------------------------------------------+"
    echo "| This script is only allowed to execute on the CentOS system"
    echo "+------------------------------------------------------------------------+"
    echo "|         Rsync base packages mirrors     "
    echo "+------------------------------------------------------------------------+"
    echo "|           For more information please visit docs                 "
    echo "+------------------------------------------------------------------------+"
    echo "| If you are running for the first time, check your environment with the check option."
    echo "| You can use the list to see which images can be synchronized."
    echo "+------------------------------------------------------------------------+"
    echo "|Use the corresponding image name to sync, or use all to sync all"
    echo "+------------------------------------------------------------------------+"
}
