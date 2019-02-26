#!/bin/bash

CONFIG_DIR=/etc/sysconfig/network-scripts/

function config_ip(){

	echo "TYPE=Ethernet
	BOOTPROTO=none
	IPV6INIT=no
	NAME=$eth 
	DEVICE=$eth
	ONBOOT=yes
	IPADDR=$ip
	PREFIX=24
	GATEWAY=$gw" > $CONFIG_DIR/ifcfg-$eth
}

function check_ip(){
	echo $ip |grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" >/dev/null
	if [ $(echo $?) !=0 ]; then
		echo "IP $ip not available!"
		exit 1
	fi
}

function menu(){
	clear
	echo -n "VM has two network devices named!"
	echo -e "\033[31m eth0 eth1 \033[0m"
	echo -ne "eth0 network segment it\t"
	echo -e "\033[36m 192.168.10.0/24 \033[0m"
	echo -ne "eth1 network segment is\t"
	echo -e "\033[36m 10.0.0.0/24 \033[0m"
	echo "Please config the correct values"
	echo 
	read -p "Choice which net device: " eth
	read -p "Enter eth IP: " ip
	read -p "Enter the gateway: " gw
}

menu

check_ip
config_ip

/usr/sbin/ifdown $eth > /dev/null
/usr/sbin/ifup $eth > /dev/null
echo -e "\033[32m $eth is configured \033[0m"

