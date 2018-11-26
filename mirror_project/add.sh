#!/bin/bash

# Author: chaos

# server

SERVER=192.168.10.45
# Set error color

Color_Text()
{
  echo -e " \e[0;$2m$1\e[0m"
}

Echo_Red()
{
  echo -e $( Color_Text "$1" "31")
}

# Check if user is root

if [ $(id -u) != "0" ]; then
    Echo_Red "Error: You are not root."
    exit 1
fi
function _check_directory(){
         if [  -d $1 ];then
         echo "$1 is ok!"
         else mkdir -p $1
         fi
}



# Get CentOS version info: 5/6/7

CENTOS_VERSION_BY_RPM=`rpm -q --queryformat '%{VERSION}' centos-release`
CENTOS_VERSION_BY_RELEASE=`cat /etc/redhat-release | grep -o '[0-9]\.[0-9]'`

# Repo files backup

Repo_Backup()
{
	_check_directory /root/backup
	mv  /etc/yum.repos.d/* /root/backup
}

# Repo files install
#sh -c "$(curl -fsSL http://192.168.10.45/mirrors/repo/add.sh)"
Repo_Install()
{
	BASE_REPO_URL="http://$SERVER/mirrors/repo/centos-"${CENTOS_VERSION_BY_RPM}".repo"
	EPEL_REPO_URL="http://$SERVER/mirrors/repo/epel-"${CENTOS_VERSION_BY_RPM}".repo"
	ZABBIX_REPO_URL="http://$SERVER/mirrors/repo/zabbix-"${CENTOS_VERSION_BY_RPM}".repo"
	NGINX_REPO_URL="http://$SERVER/mirrors/repo/nginx-"${CENTOS_VERSION_BY_RPM}".repo"
	GLIBC_REPO_URL="http://$SERVER/mirrors/repo/centos-"${CENTOS_VERSION_BY_RPM}".repo"
	REMI56_REPO_URL="http://$SERVER/mirrors/repo/remi56-"${CENTOS_VERSION_BY_RPM}".repo"
	REMI72_REPO_URL="http://$SERVER/mirrors/repo/remi72-"${CENTOS_VERSION_BY_RPM}".repo"
	MONGODB_REPO_URL="http://$SERVER/mirrors/repo/mongodb-"${CENTOS_VERSION_BY_RPM}".repo"
	MARIADB_REPO_URL="http://$SERVER/mirrors/repo/mariadb-"${CENTOS_VERSION_BY_RPM}".repo"

	curl -sS -o /etc/yum.repos.d/CentOS-Base.repo $BASE_REPO_URL
	curl -sS -o /etc/yum.repos.d/epel.repo $EPEL_REPO_URL
	curl -sS -o /etc/yum.repos.d/zabbix.repo $ZABBIX_REPO_URL
	curl -sS -o /etc/yum.repos.d/nginx.repo $NGINX_REPO_URL
	curl -sS -o /etc/yum.repos.d/epel.repo $GLIBC_REPO_URL
	curl -sS -o /etc/yum.repos.d/remi56.repo	$REMI56_REPO_URL
	curl -sS -o /etc/yum.repos.d/remi72.repo	$REMI72_REPO_URL
	curl -sS -o /etc/yum.repos.d/mongodb.repo	$MONGODB_REPO_URL
	curl -sS -o /etc/yum.repos.d/mariadb.repo	$MARIADB_REPO_URL

}

# Download and install repo files, including base and epel

if [ $CENTOS_VERSION_BY_RPM = ${CENTOS_VERSION_BY_RELEASE%%.*} ]; then
	Repo_Backup
	Repo_Install
	#echo "Repo files installed."
else
	Echo_Red "Error: unknown version of CentOS. How did you install your OS?"
fi
