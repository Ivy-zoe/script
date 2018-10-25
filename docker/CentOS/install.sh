#!/bin/bash

source /etc/profile

set -x

claer

echo "Install Docker now!"


PWD=$pwd

function Check_System(){
	yum install epel-release  -y
}


function Remove_Old_Version(){
	sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine -y
}

function Install_Dokcer(){
	sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
  	if [ -f /etc/yum.repos.d/docker.repo ]; then
  		echo "You Docker repos is Ok!"
  	else
  		cd $PWD
  		cp ./config/docker.repo /etc/yum.repos.d/docker.repo
  	fi
  	yum makecache
  	yum install docker-ce -y

}



function Remove_Docker(){
	yum remove docker -y
}

function Config_Docker_mirrors(){
	systemctl start docker
	curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io && systemctl restart docker
}

case $1 in
	install )
		Check_System
		Remove_Old_Version
		Install_Dokcer

		;;
	remove )
		Remove_Docker

	;;
	config )

	;;
	* )
	;;
esac