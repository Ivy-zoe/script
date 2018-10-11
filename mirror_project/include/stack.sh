#!/bin/bash

function Rsync_Centos7(){
        rsync -avz --exclude-from=$Config_DIR/centos7.list rsync://$TUNA/centos/7.5.1804/os/x86_64/ $CentOS7
        if [ -d $CentOS7/repodata ];then
            createrepo --update $CentOS7
        else
            createrepo $CentOS7
        fi
}

function Rsync_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/centos6.list rsync://$TUNA/centos/6.10/os/x86_64/  $CentOS6
        if [ -d $CentOS6/repodata ];then
            createrepo --update $CentOS6
        else
            createrepo $CentOS6
        fi
}

function Rsync_epel7(){
        rsync -avz --exclude-from=$Config_DIR/epel7.list  rsync://TUNA/epel/7/x86_64/ $EPEL7
        if [ -d $EPEL7/repodata ];then
            createrepo --update $EPEL7
        else
            createrepo $EPEL7
        fi
}

function Rsync_epel6(){
        rsync -avz --exclude-from=$Config_DIR/epel6.list  rsync://$TUNA/epel/7/x86_64/ $EPEL6
        if [ -d $EPEL6/repodata ];then
            createrepo --update $EPEL6
        else
            createrepo $EPEL6
        fi
}

function Curl_Nginx_For_Centos6(){
        cd $Nginx
        curl $NGINX >nginx.html &&cat nginx.html |grep 1.14 |awk -F '"' '{print $2}'|while read line; do curl -O ${NGINX}${line}; done
        if [ -d $Nginx/repodata ];then
            createrepo --update $Nginx
        else
            createrepo $Nginx
        fi
}

function Rsync_Mongodb_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/mongodb3.6.list rsync://$TUNA/mongodb/yum/el6-3.6/RPMS/ $MONGODB
        if [ -d $MONGODB/repodata ];then
            createrepo --update $MONGODB
        else
            createrepo $MONGODB
        fi
}

function Rysnc_Mariadb_For_CentOS7(){
        rsync -avz  rsync://$TUNA/mariadb/mariadb-10.3.8/yum/centos73-amd64/ $Mariadb
        if [ -d $Mariadb/repodata ];then
            createrepo --update $Mariadb
        else
            createrepo $Mariadb
        fi
}

function Rsync_Zabbix_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos6.list rsync://$TUNA/zabbix/zabbix/3.4/rhel/6/x86_64/ $ZABBIX6
        if [ -d $ZABBIX6/repodata ];then
            createrepo --update $ZABBIX6
        else
            createrepo $ZABBIX6
        fi
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos6.list rsync://$TUNA/zabbix/zabbix/3.4/rhel/6/x86_64/deprecated $ZABBIX6/deprecated
        if [ -d $ZABBIX6/deprecated/repodata ];then
            createrepo --update $ZABBIX6/deprecated
        else
            createrepo $ZABBIX6/deprecated
        fi
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos6.list rsync://$TUNA/zabbix/zabbix/3.4/rhel/6/SRPMS $ZABBIX6/SRPMS
        if [ -d $ZABBIX6/SRPMS/repodata ];then
            createrepo --update $ZABBIX6/SRPMS
        else
            createrepo $ZABBIX6/SRPMS
        fi
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos6.list rsync://$TUNA/non-supported/rhel/6/x86_64 $ZABBIX6/non-supported
        if [ -d $ZABBIX6/non-supported/repodata ];then
            createrepo --update $ZABBIX6/non-supported
        else
            createrepo $ZABBIX6/non-supported
        fi
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos6.list rsync://$TUNA/non-supported/rhel/6/SRPMS $ZABBIX6/non-supported/SRPMS
        if [ -d $ZABBIX6/non-supported/SRPMS/repodata ];then
            createrepo --update $ZABBIX6/non-supported/SRPMS
        else
            createrepo $ZABBIX6/non-supported/SRPMS
        fi
}

function Rsync_Zabbix_For_Centos7(){
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos7.list rsync://$TUNA/zabbix/zabbix/3.4/rhel/7/x86_64/ $ZABBIX7
        if [ -d $ZABBIX7/repodata ];then
            createrepo --update $ZABBIX7
        else
            createrepo $ZABBIX7
        fi
        rsync -avz rsync://$TUNA/zabbix/non-supported/rhel/7/x86_64/ $ZABBIX7/non-supported
        if [ -d ZABBIX7/non-supported/repodata ];then
            createrepo --update $ZABBIX7/non-supported
        else
            createrepo $ZABBIX7/non-supported
        fi
        rsync -avz rsync://$TUNA/zabbix/non-supported/rhel/7/SRPMS/ $ZABBIX7/non-supported/SRPMS
        if [ -d ZABBIX7/non-supported/SRPMS/repodata ];then
            createrepo --update $ZABBIX7/non-supported/SRPMS
        else
            createrepo $ZABBIX7/non-supported/SRPMS
        fi
        rsync -avz --exclude-from=$Config_DIR/zabbix-for-centos7.list rsync://$TUNA/zabbix/zabbix/3.4/rhel/7/SRPMS $ZABBIX7/SRPMS
        if [ -d ZABBIX7/SRPMS/repodata ];then
            createrepo --update $ZABBIX7/SRPMS
        else
            createrepo $ZABBIX7/SRPMS
        fi
}
function Rsync_Remi_For_Centos6(){
        rsync -avz --exclude-from=$Config_DIR/remi.list rsync://$TUNA/remi/6Server/php72/x86_64/ $REMI/php72
        if [ -d $REMI/php72/repodata ];then
            createrepo --update $REMI/php72
        else
            createrepo $MEMI/php72
        fi
        rsync -avz --exclude-from=$Config_DIR/remi.list rsync://$TUNA/remi/6Server/php56/x86_64/ $REMI/php56
        if [ -d $REMI/php56/repodata ];then
            createrepo --update $REMI/php56
        else
            createrepo $REMI/php56
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
