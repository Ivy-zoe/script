#!/bin/bash
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
}
# check dir

mkdir -p $WORK_DIR
mkdir -p $DATA_DIR
mkdir -p $EPEL7
mkdir -p $EPEL7
mkdir -p $CentOS6
mkdir -p $MONGODB
mkdir -p $CentOS7
mkdir -p $Mariadb
mkdir -p $Nginx
mkdir -p $GLIBC
mkdir -p $ZABBIX6/deprecated
mkdir -p $ZABBIX6/SRPMS
mkdir -p $ZABBIX6/non-supported/SRPMS
mkdir -p $ZABBIX7/non-supported/SRPMS
mkdir -p $ZABBIX7/SRPMS
mkdir -p $REMI/php72
mkdir -p $REMI/php56
mkdir -p $influxdata6
mkdir -p $influxdata7

function Updata_Config(){
    cp -r ./config $WORK_DIR

}



function all(){
	    Rsync_Centos6
        Rsync_Centos7
        Rsync_epel7
        Rsync_epel6
        Rsync_Remi_For_Centos6
        Rsync_Mongodb_For_Centos6
        Curl_Nginx_For_Centos6
        Curl_Glibc_For_CentOS6
        Rysnc_Mariadb_For_CentOS7
        Rsync_Zabbix_For_Centos7
        Rsync_Zabbix_For_Centos6
}

 



