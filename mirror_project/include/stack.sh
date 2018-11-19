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
	_rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/os/x86_64 $CentOS6/os/x86_64
	_update_repos $CentOS6/os/x86_64
	_rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/updates/x86_64 $CentOS6/updates/x86_64
	_update_repos $CentOS6/updates/x86_64

	_rsync_mirrors $Config_DIR/centos6.list $rsync_tuna/centos/6/extras/x86_64	
	
	_update_repos $CentOS6/extras/x86_64


#	_update_repos CentOS6
}

#function _rsync_EPEL6(){

#}

#function _rsync_EPEL7(){
#	_rsync_mirrors $Config_DIR/epel7.list $rsync_tuna/epel/7 $EPEL7
#}

#function _rsync_mariadb7(){
#	_rsync_mirrors $Config_DIR/

#}

#function _rsync_remi(){

#}

#function _zabbix_6(){

#}

#function _zabbix_7(){

#}


function _wget_glibc(){
	_wget_incloud_file $Config_DIR/gilbc-2.15-wget-list $GLIBC

}

