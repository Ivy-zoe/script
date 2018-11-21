#!/bin/bash


function _rsync_CentOS7(){
	#base 
	_rsync_mirrors $Config_DIR/centos7.list $rsync_tuna/centos/7/os/x86_64/ $CentOS7/os/x86_64
	_update_repos	$CentOS7/os/x86_64
	# updates
	_rsync_mirrors $Config_DIR/centos7.list $rsync_tuna/centos/7/updates/x86_64/ $CentOS7/updates/x86_64/
	_update_repos 	$CentOS7/updates/x86_64/
	# extras
	_rsync_mirrors $Config_DIR/centos7.list $rsync_tuna/centos/7/extras/x86_64/ $CentOS7/extras/x86_64/
	_update_repos	$CentOS7/extras/x86_64/ 
}

function _rsync_CentOS6(){
	# base
	_rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/os/x86_64 $CentOS6/os/x86_64
	_update_repos $CentOS6/os/x86_64
	# updates
	_rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/updates/x86_64 $CentOS6/updates/x86_64
	_update_repos $CentOS6/updates/x86_64
	# extras
	_rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/extras/x86_64	$CentOS6/extras/x86_64
	_update_repos $CentOS6/extras/x86_64
}

function _rsync_EPEL6(){
	# rsync mirros
	_rsync_mirrors $Config_DIR/epel6.list $rsync_tuna/epel/6/x86_64/ $EPEL6/x86_64/
	# update repodate
	_update_repos $EPEL6/x86_64/
}

function _rsync_EPEL7(){
	_rsync_mirrors $Config_DIR/epel7.list $rsync_tuna/epel/7/x86_64/ $EPEL7/x86_64/
	_update_repos $EPEL7/x86_64
}

function _rsync_mariadb7(){
	_rsync_mirrors $Config_DIR/mariadb.list $rsync_tuna/mariadb/yum/10.3/centos/7.4/x86_64/ $Mariadb7/x86_64
	_update_repos $Mariadb7/x86_64

}

function _rsync_mariadb6(){
	_rsync_mirrors $Config_DIR/mariadb.list $rsync_tuna/mariadb/yum/10.3/centos/6/x86_64/ $Mariadb6/x86_64
	_update_repos $Mariadb6/x86_64

}

function _rsync_remi_56(){
	_rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/php56/x86_64/ $REMI6/56/x86_64/
	_update_repos $REMI6/56/x86_64/

}

function _rsync_remi_72(){
	_rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/php72/x86_64/ $REMI6/72/x86_64/
	_update_repos $REMI6/72/x86_64/
}

function _rsync_remi_56_7(){
	_rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/php56/x86_64/ $REMI7/56/x86_64/
	_update_repos $REMI7/56/x86_64/

}

function _rsync_remi_72_7(){
	_rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/php72/x86_64/ $REMI7/72/x86_64/
	_update_repos $REMI7/72/x86_64/
}

function _zabbix_6(){
	# base
	_rsync_mirrors $Config_DIR/zabbix-for-centos6.list $rsync_tuna/zabbix/zabbix/3.4/rhel/6/x86_64/ $ZABBIX6/x86_64/
	_update_repos $ZABBIX6/x86_64/
	# non-supported
	_rsync_mirrors $Config_DIR/zabbix-for-centos6.list $rsync_tuna/zabbix/non-supported/rhel/6/x86_64/ $ZABBIX6/non-supported/x86_64/
	_update_repos $ZABBIX6/non-supported/x86_64/
}


function _zabbix_7(){
	# base
	_rsync_mirrors $Config_DIR/zabbix-for-centos7.list $rsync_tuna/zabbix/zabbix/3.4/rhel/7/x86_64/ $ZABBIX7/x86_64/
	_update_repos $ZABBIX7/x86_64/
	# non-supported
	_rsync_mirrors $Config_DIR/zabbix-for-centos7.list $rsync_tuna/zabbix/non-supported/rhel/7/x86_64/ $ZABBIX7/non-supported/x86_64/
	_update_repos $ZABBIX7/non-supported/x86_64/
}


function _wget_glibc(){
	_wget_incloud_file $Config_DIR/gilbc-2.15-wget-list $GLIBC
	_update_repos $GLIBC
}

function _mongodb_3.6(){
	_rsync_mirrors $Config_DIR/mongodb3.6.list $rsync_tuna/mongodb/yum/el6-3.6/	$MONGODB6
	_update_repos $MONGODB6
}

function _nginx_centos6(){
	_wget_incloud_file	$Config_DIR/nginx-wget-list	$Nginx
	_update_repos $Nginx
}
