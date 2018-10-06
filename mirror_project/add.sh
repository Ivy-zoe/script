#!/bin/bash


function mv_back(){
	cd ~
	if [ -d repos ];then
		echo "repos dir is ok"
	else
		mkdir repos
	fi
}

function mv_repo_file(){
	if [ -f /etc/yum.repos.d/CentOS-Base.repo ];then
		mv /etc/yum.repos.d/* ~/repos
	else
		echo "file is ok!"
}

function add_repo_files(){
	cp ./repo/mirror.repo /etc/yum.repos.d/

}

case $1 in
	add )
		mv_back
		mv_repo_file
		add_repo_files

		;;
	* )
		echo add
	;;
esac