#!/bin/bash


sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
sudo cp ./CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
yum makecache

yum install epel-release -y

sudo mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.bak
sudo cp ./epel.repo /etc/yum.repos.d/epel.repo
