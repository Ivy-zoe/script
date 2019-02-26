#!/bin/bash


### base ip config

## eth0 192.168.10.0/24
## eth1 10.0.0.0/24


## eth0

cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
TYPE="Ethernet"
BOOTPROTO="none"
IPV6INIT="no"
NAME="eth0"
DEVICE="eth0"
ONBOOT="yes"
IPADDR="192.168.10.$1"
PREFIX="24"
EOF

## eth1



cat > /etc/sysconfig/network-scripts/ifcfg-eth1 << EOF
TYPE="Ethernet"
BOOTPROTO="none"
DEFROUTE="yes"
IPV6INIT="no"
NAME="eth1"
DEVICE="eth1"
ONBOOT="yes"
IPADDR="10.0.0.$1"
PREFIX="24"
GATEWAY=10.0.0.1
EOF