#!/bin/bash

# Author: Li Guanghui

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

# Check if OS is indeed CentOS

if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then :
    #echo "CentOS Detected."
    #pass
else
    Echo_Red "Error: This is not CentOS. RHEL, Fedora, or any other OS is not supported."
    exit 1
fi

# Get CentOS version info: 5/6/7

CENTOS_VERSION_BY_RPM=`rpm -q --queryformat '%{VERSION}' centos-release`
CENTOS_VERSION_BY_RELEASE=`cat /etc/redhat-release | grep -o '[0-9]\.[0-9]'`

# Repo files backup

Repo_Backup()
{
    if [ -f "/etc/yum.repos.d/CentOS-Base.repo" ]; then
        mv --backup=t /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    fi

    if [ -f "/etc/yum.repos.d/epel.repo" ]; then
	mv --backup=t /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup
    fi
}

# Repo files install

Repo_Install()
{
	BASE_REPO_URL="http://mirrors.deppon.com/repo/centos-"${CENTOS_VERSION_BY_RPM}".repo"
	EPEL_REPO_URL="http://mirrors.deppon.com/repo/epel-"${CENTOS_VERSION_BY_RPM}".repo"
	curl -sS -o /etc/yum.repos.d/CentOS-Base.repo $BASE_REPO_URL
	curl -sS -o /etc/yum.repos.d/epel.repo $EPEL_REPO_URL
}

# Download and install repo files, including base and epel

if [ $CENTOS_VERSION_BY_RPM = ${CENTOS_VERSION_BY_RELEASE%%.*} ]; then
	Repo_Backup
	Repo_Install
	#echo "Repo files installed."
else
	Echo_Red "Error: unknown version of CentOS. How did you install your OS?"
fi
