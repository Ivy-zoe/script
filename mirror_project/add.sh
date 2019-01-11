#!/bin/bash

# Author: chaos

# server

SERVER=10.0.0.10
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
_check_directory(){
         if [  -d $1 ];then
         echo "$1 is ok!"
         else
         	mkdir -p $1
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
BASE_REPO()
{
	BASE_REPO_URL="http://$SERVER/mirrors/repo/centos-"${CENTOS_VERSION_BY_RPM}".repo"
	EPEL_REPO_URL="http://$SERVER/mirrors/repo/epel-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/CentOS-Base.repo $BASE_REPO_URL
	curl -sS -o /etc/yum.repos.d/epel.repo $EPEL_REPO_URL
}

ZABBIX(){
	ZABBIX_REPO_URL="http://$SERVER/mirrors/repo/zabbix-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/zabbix.repo $ZABBIX_REPO_URL
}

NGINX(){
	NGINX_REPO_URL="http://$SERVER/mirrors/repo/nginx-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/nginx.repo $NGINX_REPO_URL

}

MONGODB(){
	MONGODB_REPO_URL="http://$SERVER/mirrors/repo/mongodb-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/mongodb.repo	$MONGODB_REPO_URL

}

MARIADB(){
	MARIADB_REPO_URL="http://$SERVER/mirrors/repo/mariadb-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/mariadb.repo	$MARIADB_REPO_URL
}

REMI(){
	REMI56_REPO_URL="http://$SERVER/mirrors/repo/remi56-"${CENTOS_VERSION_BY_RPM}".repo"
	REMI72_REPO_URL="http://$SERVER/mirrors/repo/remi72-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/remi56.repo	$REMI56_REPO_URL
	curl -sS -o /etc/yum.repos.d/remi72.repo	$REMI72_REPO_URL
}

JDK(){
	JDK_URL="http://$SERVER/mirrors/repo/jdk.repo"
	curl -sS -o /etc/yum.repos.d/jdk.repo $JDK_URL
}

ELK(){
	ELK_URL="http://$SERVER/mirrors/repo/elk.repo"
	curl -sS -o /etc/yum.repos.d/elk.repo $ELK_URL
}

GLIBC(){
	GLIBC_URL="http://$SERVER/mirrors/repo/glibc.repo"
	curl -sS -o /etc/yum.repos.d/glibc.repo $GLIBC_URL
}
_HELP(){

    clear
    echo "+---------------------------------------------------------------------------------------+"
    echo "| Number  images_command     do                                 "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 1       all      backup repos_files then add mirrors all repos_files  "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 2       init_base	backup repos_files then add epel and CentOS6&7 repos_files   "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 3       nginx        add nginx repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 4       mongodb    add mongodb repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 5       mariadb   add mariadb repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 6       remi      add remi56&remi72 repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 7       zabbix      add zabbix repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 8       jdk      add jdk repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 9       elk      add elk repos_files"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 10       glibc      add glibc for centos6 repos_files"
    echo "+---------------------------------------------------------------------------------------+"

}

case $1 in
	all )
		Repo_Backup
		BASE_REPO
		ZABBIX
		MONGODB
		MARIADB
		NGINX
		REMI
		JDK
		ELK
		;;
	init_base )
		Repo_Backup
		BASE_REPO
	;;
	zabbix )
		ZABBIX
	;;
	mongodb )
		MONGODB
	;;
	mariadb )
		MARIADB
	;;
	nginx )
		NGINX
	;;
	remi )
		REMI
	;;
	jdk )
		JDK
	;;
	elk )
		ELK
	;;
	glibc )
		GLIBC
	;;
	help )
		_HELP
	;;

	* )
		Echo_Red "Please type help or repos_name!"
	;;
esac
