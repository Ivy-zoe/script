#!/bin/bash


# env config

Config_DIR=./config
DATA_DIR=/data/mirrors
#DATA_DIR=/Users/chaos/Desktop/tmp

# data
#DATA_DIR=/Users/chaos/Desktop/tmp
EPEL6=$DATA_DIR/epel/6
EPEL7=$DATA_DIR/epel/7
CentOS7=$DATA_DIR/centos/7
CentOS6=$DATA_DIR/centos/6
MONGODB6=$DATA_DIR/mongodb/6
Mariadb=$DATA_DIR/mariadb/7
Nginx=$DATA_DIR/nginx/6
REMI6=$DATA_DIR/remi/6
REMI7=$DATA_DIR/remi/7
ZABBIX6=$DATA_DIR/zabbix/6
ZABBIX7=$DATA_DIR/zabbix/7
GLIBC=$DATA_DIR/glibc/6
REPO=$DATA_DIR/repo

# web
MIRRORS_WEB=mirrors
WEB_EPEL6=$MIRRORS_WEB/epel/6
WEB_EPEL7=$MIRRORS_WEB/epel/7
WEB_CentOS7=$MIRRORS_WEB/centos/7
WEB_CentOS6=$MIRRORS_WEB/centos/6
WEB_MONGODB6=$MIRRORS_WEB/mongodb/6
WEB_Mariadb=$MIRRORS_WEB/mariadb/7
WEB_NGINX=$MIRRORS_WEB/nginx/6
WEB_REMI=$MIRRORS_WEB/remi/6
WEB_REMI_7=$MIRRORS_WEB/remi/7
WEB_ZABBIX6=$MIRRORS_WEB/zabbix/6
WEB_ZABBIX7=$MIRRORS_WEB/zabbix/7
WEB_GLIBC=$MIRRORS_WEB/glibc/6
WEB_REPO=$MIRRORS_WEB/repo



# check dir

function Check_directory(){

    _check_directory $DATE_DIR
    _check_directory $CentOS7/os/x86_64
    _check_directory $CentOS7/updates/x86_64/
    _check_directory $CentOS7/extras/x86_64/
    _check_directory $CentOS6/os/x86_64
    _check_directory $CentOS6/updates/x86_64
    _check_directory $CentOS6/extras/x86_64
    _check_directory $EPEL6/x86_64/
    _check_directory $EPEL7/x86_64
    _check_directory $Mariadb/x86_64
    _check_directory $REMI6/56/x86_64/
    _check_directory $REMI6/72/x86_64/
    _check_directory $REMI7/56/x86_64/
    _check_directory $REMI7/72/x86_64/
    _check_directory $ZABBIX6/x86_64/
    _check_directory $ZABBIX6/non-supported/x86_64/
    _check_directory $ZABBIX7/x86_64/
    _check_directory $ZABBIX7/non-supported/x86_64/
    _check_directory $GLIBC
    _check_directory $MONGODB6
    _check_directory $Nginx
    _check_directory $REPO

}



# rsync_url
rsync_tuna=rsync://mirrors.tuna.tsinghua.edu.cn


function _check_path(){

    _check_command_and_yum_install  rsync
    _check_command_and_yum_install  createrepo
    _check_command_and_yum_install wget
}

