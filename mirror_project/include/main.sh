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
function Check_Work_Dir(){
    if [ -d $WORK_DIR ]; then echo work_dir_is_ok! ; else `mkdir -p $WORK_DIR`  `cp -r ./config $WORK_DIR` ; fi

}
# Check Data Dir
function Check_Data_Dir(){
    if [ -d $DATA_DIR ]; then echo data_dir_is_ok! ; else mkdir -p $DATA_DIR ; fi
}
function Check_Mirros_Dir(){
    if [ -d $EPEL6 ]; then echo mirrors_dir_is_ok! ; else `mkdir -p $EPEL6` `mkdir -p $EPEL7` `mkdir -p $CentOS7` `mkdir -p $CentOS6` `mkdir -p $MONGODB` `mkdir -p $Mariadb` `mkdir -p $Nginx` `mkdir -p $REMI` `mkdir -p $ZABBIX6` `mkdir -p $ZABBIX7` `mkdir -p $GLIBC` `mkdir -p $ZABBIX6/deprecated` `mkdir -p $ZABBIX6/SRPMS` `mkdir -p $ZABBIX6/non-supported` `mkdir -p $ZABBIX6/non-supported/SRPMS ` `mkdir -p $ZABBIX7/non-supported` `mkdir -p $ZABBIX7/non-supported/SRPMS` `mkdir -p $ZABBIX7/SRPMS` `mkdir -p $REMI/php72` `mkdir -p $REMI/php56` ; fi
}


function all(){
	    Rsync_Centos6
        Rsync_Centos7
        Rsync_epel7
        Rsync_epel6
        Rsync_Remi_For_Centos6
        Rsync_Mongodb_For_Centos6
        Rsync_Nginx_For_Centos6
        Rysnc_Mariadb_For_CentOS7
        Rsync_Zabbix_For_Centos7
        Rsync_Zabbix_For_Centos6
}

 



