#!/bin/bash



## CentOS7 base
function _rsync_CentOS7(){
    #base
    _rsync_mirrors $Config_DIR/centos7.list $rsync_tuna/centos/7/os/x86_64/ $CentOS7/os
    _update_repos	$CentOS7/os/
    # updates
    _rsync_mirrors $Config_DIR/centos7.list $rsync_tuna/centos/7/updates/x86_64/ $CentOS7/updates
    _update_repos   $CentOS7/updates/
    # extras
    _rsync_mirrors $Config_DIR/centos7.list $rsync_tuna/centos/7/extras/x86_64/ $CentOS7/extras
    _update_repos	$CentOS7/extras/
}

## CentOS6 base
function _rsync_CentOS6(){
    # base
    _rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/os/x86_64 $CentOS6/os
    _update_repos $CentOS6/os
    # updates
    _rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/updates/x86_64 $CentOS6/updates
    _update_repos $CentOS6/updates
    # extras
    _rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/extras/x86_64	$CentOS6/extras
    _update_repos $CentOS6/extras
}

## EPEL6
function _rsync_EPEL6(){
    # rsync mirros
    _rsync_mirrors $Config_DIR/epel6.list $rsync_tuna/epel/6/x86_64/ $EPEL6
    # update repodate
    _update_repos $EPEL6
}

## EPEL7
function _rsync_EPEL7(){
    _rsync_mirrors $Config_DIR/epel7.list $rsync_tuna/epel/7/x86_64/ $EPEL7
    _update_repos $EPEL7
}

## Mariadb10.3 for CentOS7 

function _rsync_mariadb7(){
    _rsync_mirrors $Config_DIR/mariadb.list $rsync_tuna/mariadb/yum/10.3/centos/7.4/x86_64/ $Mariadb7
    _update_repos $Mariadb7

}

## Mariadb10.3 for CentOS6
function _rsync_mariadb6(){
    _rsync_mirrors $Config_DIR/mariadb.list $rsync_tuna/mariadb/yum/10.3/centos/6/x86_64/ $Mariadb6
    _update_repos $Mariadb6

}


## REMI for CentOS6
function _rsync_remi_6(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/remi/x86_64/ $REMI6/x86_64/
    _update_repos $REMI6/x86_64/
}

## REMI for CentOS6

function _rsync_remi_56_6(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/php56/x86_64/ $REMI6/56
    _update_repos $REMI6/56/

}

## REMI for CentOS7
function _rsync_remi_72_6(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/php72/x86_64/ $REMI6/72
    _update_repos $REMI6/72/
}

## REMI for CentOS7
function _rysnc_remi_7(){
    _rsync_mirrors $Config_DIR/remi.list  $rsync_tuna/remi/enterprise/7/remi/x86_64/ $REMI7/x86_64/
    _update_repos $REMI7/x86_64
}

function _rsync_remi_56_7(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/php56/x86_64/ $REMI7/56
    _update_repos $REMI7/56/

}

function _rsync_remi_72_7(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/php72/x86_64/ $REMI7/72
    _update_repos $REMI7/72
}


function _zabbix_6(){
    # base
    _rsync_mirrors $Config_DIR/zabbix-for-centos6.list $rsync_tuna/zabbix/zabbix/3.4/rhel/6/x86_64/ $ZABBIX6/x86_64/
    _update_repos $ZABBIX6/x86_64/
    # non-supported
    _rsync_mirrors $Config_DIR/zabbix-for-centos6.list $rsync_tuna/zabbix/non-supported/rhel/6/x86_64/ $ZABBIX6/non-supported
    _update_repos $ZABBIX6/non-supported/x86_64/
}


function _zabbix_7(){
    # base
    _rsync_mirrors $Config_DIR/zabbix-for-centos7.list $rsync_tuna/zabbix/zabbix/3.4/rhel/7/x86_64/ $ZABBIX7/x86_64/
    _update_repos $ZABBIX7/x86_64/
    # non-supported
    _rsync_mirrors $Config_DIR/zabbix-for-centos7.list $rsync_tuna/zabbix/non-supported/rhel/7/x86_64/ $ZABBIX7/non-supported
    _update_repos $ZABBIX7/non-supported/x86_64/
}


function _wget_glibc(){
    _wget_incloud_file $Config_DIR/gilbc-2.15-wget-list $GLIBC
    _update_repos $GLIBC
}

function _mongodb_3.6_6(){
    _rsync_mirrors $Config_DIR/mongodb3.6.list $rsync_tuna/mongodb/yum/el6-3.6/RPMS/	$MONGODB6
    _update_repos $MONGODB6
}

function _mongodb_3.6_7(){
    _rsync_mirrors $Config_DIR/mongodb3.6.list $rsync_tuna/mongodb/yum/el7-3.6/RPMS/    $MONGODB7
    _update_repos $MONGODB7
}


function _nginx_centos6(){
    _wget_incloud_file	$Config_DIR/nginx6-wget-list	$Nginx6
    _update_repos $Nginx6
}

function _nginx_centos7(){
    _wget_incloud_file  $Config_DIR/nginx7-wget-list $Nginx7
    _update_repos $Nginx7
}


function _pinpoint(){
    _wget_incloud_file $Config_DIR/pinpoint-wget-list $pinpoint
    _update_repos $pinpoint
}

function _openstack_r(){
    _rsync_mirrors $Config_DIR/openstack.list $rsync_tuna/centos/7.6.1810/cloud/x86_64/openstack-rocky/ $Rocky
    _update_repos $Rocky
}


function _docker_ce(){
    _rsync_mirrors $Config_DIR/docker.list $rsync_tuna/docker/yum/repo/centos7/Packages/ $DOCKER
    _update_repos $DOCKER
}

