#!/bin/bash
## =======Rsync script =======

# debug
#set -e
# Dir
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

TUNA=mirrors.tuna.tsinghua.edu.cn
USTC=mirrors.ustc.edu.cn
REDSLEVE=http://ftp.redsleeve.org/pub/steam/
# Check Software
function Check_Software(){
    type rsync >/dev/null 2>&1 || { echo >&2 "I require rsync but it's not installed.  Aborting."; yum install rsync -y; }
    type createrepo >/dev/null 2>&1 || { echo >&2 "I require createrepo but it's not installed.  Aborting."; yum install createrepo -y; }
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
    if [ -d $EPEL6 ]; then echo mirrors_dir_is_ok! ; else `mkdir -p $EPEL6` `mkdir -p $EPEL7` `mkdir -p $CentOS7` `mkdir -p $CentOS6` `mkdir -p $MONGODB` `mkdir -p $Mariadb` `mkdir -p $Nginx` `mkdir -p $REMI` `mkdir -p $ZABBIX6` `mkdir -p $ZABBIX7` `mkdir -p $GLIBC`; fi
}

function Rsync_Centos7(){
        rsync -avz --exclude-from=$Config_DIR/centos7.list rsync://mirrors.tuna.tsinghua.edu.cn/centos/7.5.1804/os/x86_64/ $CentOS7
        if [ -d $CentOS7/repodata ];then
            createrepo --update $CentOS7
        else
            createrepo $CentOS7
        fi
}

function Rsync_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/centos6.list rsync://mirrors.tuna.tsinghua.edu.cn/centos/6.10/os/x86_64/  $CentOS6
        if [ -d $CentOS6/repodata ];then
            createrepo --update $CentOS6
        else
            createrepo $CentOS6
        fi
}

function Rsync_epel7(){
        rsync -avz --exclude-from=$Config_DIR/epel7.list  rsync://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/ $EPEL7
        if [ -d $EPEL7/repodata ];then
            createrepo --update $EPEL7
        else
            createrepo $EPEL7
        fi
}


function Rsync_epel6(){
        rsync -avz --exclude-from=$Config_DIR/epel6.list  rsync://mirrors.tuna.tsinghua.edu.cn/epel/7/x86_64/ $EPEL6
        if [ -d $EPEL6/repodata ];then
            createrepo --update $EPEL6
        else
            createrepo $EPEL6
        fi
}

function Rsync_Nginx_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/nginx-for-centos6.list rsync://rsync.mirrors.ustc.edu.cn/repo/nginx/rhel/6/x86_64/ $Nginx
        if [ -d $Nginx/repodata ];then
            createrepo --update $Nginx
        else
            createrepo $Nginx
        fi
}

function Rsync_Mongodb_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/mongodb3.6.list rsync://mirrors.tuna.tsinghua.edu.cn/mongodb/yum/el6-3.6/ $MONGODB
        if [ -d $MONGODB/repodata ];then
            createrepo --update $MONGODB
        else
            createrepo $MONGODB
        fi
}

function Rysnc_Mariadb_For_CentOS7(){
        rsync -avz  rsync://mirrors.tuna.tsinghua.edu.cn/mariadb/mariadb-10.3.8/yum/centos73-amd64/ $Mariadb
        if [ -d $Mariadb/repodata ];then
            createrepo --update $Mariadb
        else
            createrepo $Mariadb
        fi
}

function Rsync_Zabbix_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos6.list rsync://mirrors.tuna.tsinghua.edu.cn/zabbix/zabbix/3.4/rhel/6/x86_64/ $ZABBIX6
        if [ -d $ZABBIX6/repodata ];then
            createrepo --update $ZABBIX6
        else
            createrepo $ZABBIX6
        fi
}
function Rsync_Zabbix_For_Centos7(){
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos7.list rsync://mirrors.tuna.tsinghua.edu.cn/zabbix/zabbix/3.4/rhel/7/x86_64/ $ZABBIX7
        if [ -d $ZABBIX7/repodata ];then
            createrepo --update $ZABBIX7
        else
            createrepo $ZABBIX7
        fi
}
function Rsync_Remi_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/remi.list rsync://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/ $REMI
        if [ -d $REMI/repodata ];then
            createrepo --update $REMI
        else
            createrepo $MEMI
        fi
}

function Curl_Glibc_For_CentOS6(){
        cd $GLIBC
        curl $REDSLEVE >glibc.html &&cat glibc.html |awk -F '"' '{print $8}' |grep -v ^$|while read line; do curl -O ${REDSLEVE}${line}; done
        if [ -d $GLIBC/repodata ];then
            createrepo --update $GLIBC
        else
            createrepo $GLIBC
        fi  
}

function List(){
    clear
    echo "+---------------------------------------------------------------------------------------+"
    echo "| Number  Images_Name    Website                      Local_Path           "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 1       nginx         $USTC        $Nginx "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 2       epel6         $TUNA        $EPEL6   "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 3       epel7         $TUNA        $EPEL7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 4       centos7       $TUNA        $CentOS7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 5       centos6       $TUNA        $CentOS6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 6       mariadb   $TUNA        $Mariadb"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 7       remi           $TUNA       $REMI"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 8       mongodb     $TUNA        $MONGODB"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 9       zabbix6       $TUNA        $ZABBIX6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 10      zabbix7       $TUNA         $ZABBIX7"
    echo "+---------------------------------------------------------------------------------------+" 
    echo "|                 Curl "
    echo "+---------------------------------------------------------------------------------------+" 
    echo "| 11      glibc        $REDSLEVE         $GLIBC"  
    echo "+---------------------------------------------------------------------------------------+" 
}

#set -x
case $1 in
    check )
        Check_Mirros_Dir
        Check_Work_Dir
        Check_Software
        Check_Data_Dir
        ;;
    nginx )
        Rsync_Nginx_For_Centos6
        ;;
    epel6 )
        Rsync_epel6
        ;;
    epel7 )
        Rsync_epel7
        ;;
    mongodb )
        Rsync_Mongodb_For_Centos6
        ;;
    mariadb )
        Rysnc_Mariadb_For_CentOS7
        ;;
    remi )
        Rsync_Remi_For_Centos6
        ;;
    centos6 )
        Rsync_Centos6
        ;;
    centos7 )
        Rsync_Centos7
        ;;
    zabbix6 )
        Rsync_Zabbix_For_Centos6
    ;;
    zabbix7 )
        Rsync_Zabbix_For_Centos7
    ;;
    glibc )
        Curl_Glibc_For_CentOS6
    ;;
    all )
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
        Curl_Glibc_For_CentOS6
        ;;
    list )
        List
    ;;
    *)
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
esac
