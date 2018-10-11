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

 



