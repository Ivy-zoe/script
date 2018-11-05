#!/bin/bash
WORK_DIR=/opt/soft/mirror_project
cur_dir=$(pwd)
DATA_DIR=/data/mirrors
EPEL6=$DATA_DIR/epel/6
EPEL7=$DATA_DIR/epel/7
CentOS7=$DATA_DIR/centos/7
CentOS6=$DATA_DIR/centos/6
MONGODB=$DATA_DIR/mongodb/6
Mariadb=$DATA_DIR/mariadb/7

REMI=$DATA_DIR/remi/6
ZABBIX6=$DATA_DIR/zabbix/6
ZABBIX7=$DATA_DIR/zabbix/7
GLIBC=$DATA_DIR/glibc/6

MYSQL57=$DATA_DIR/mysql57/7
PMM=$DATA_DIR/pmm/6
TUNA=mirrors.tuna.tsinghua.edu.cn
USTC=mirrors.ustc.edu.cn


rsync -avz --exclude-from=$cur_dir/config/centos6.list rsync://$TUNA/centos/6.10/ $CentOS6

rsync -avz --exclude-from=$cur_dir/config/centos7.list rsync://$TUNA/centos/7.5.1804/ $CentOS7
rsync -avz --exclude-from=$cur_dir/config/epel6.list rsync://$TUNA/epel/6 $EPEL6
rsync -avz --exclude-from=$cur_dir/config/epel7.list rsync://$TUNA/epel/7  $EPEL7
