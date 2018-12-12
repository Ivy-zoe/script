#!/bin/bash


# env config

Config_DIR=./config
DATA_DIR=/data/mirrors
#DATA_DIR=/Users/chaos/Desktop/tmp


#EPEL
EPEL6=$DATA_DIR/epel/6
EPEL7=$DATA_DIR/epel/7
# CentOS
CentOS7=$DATA_DIR/centos/7
CentOS6=$DATA_DIR/centos/6
# Mongodb
MONGODB6=$DATA_DIR/mongodb/6
# Mariadb
Mariadb7=$DATA_DIR/mariadb/7
Mariadb6=$DATA_DIR/mariadb/6
# Nginx
Nginx=$DATA_DIR/nginx/6
# REMI
REMI6=$DATA_DIR/remi/6
REMI7=$DATA_DIR/remi/7
# zabbix
ZABBIX6=$DATA_DIR/zabbix/6
ZABBIX7=$DATA_DIR/zabbix/7
# Glibc
GLIBC=$DATA_DIR/glibc/6

# pinpoint
pinpoint=$DATA_DIR/pinpoint
# Repos
REPO=$DATA_DIR/repo
# Glpi
GLPI_91=$DATA_DIR/glpi/6/91
GLPI_93=$DATA_DIR/glpi/6/93

#### ------------
#### ------------
#### ------------
#### ---WEB------
WEB=mirrors

## END

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
    _check_directory $Mariadb7/x86_64
    _check_directory $Mariadb6/x86_64
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
    _check_directory $GLPI_91
    _check_directory $GLPI_93
    _check_directory $pinpoint
}



# rsync_url
rsync_tuna=rsync://mirrors.tuna.tsinghua.edu.cn


function _check_path(){

    _check_command_and_yum_install  rsync
    _check_command_and_yum_install  createrepo
    _check_command_and_yum_install wget
}
