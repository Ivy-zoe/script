#!/bin/bash

## local install docker-ce


source /etc/profile


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
  lvm2 docker-ce
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
		Remove_Old_Version
		Install_Dokcer

		;;
	remove )
		Remove_Docker

	;;
	config )
		Config_Docker_mirrors

	;;
	* )
		echo "Please type install,remove or config!"
	;;
esac
