#!/bin/bash

set -x

if [ -e ./lib/libs.so ]; then
	source ./lib/libs.so
		if [ $? = 0 ]; then
		echo "Load Library OK."
		fi
	else
	echo "Check library.so Not Found!!!"
	exit 9
fi
_source_file_exist ./include/list.sh
_source_file_exist ./include/stack.sh
_source_file_exist ./include/main.sh


_check_command_and_yum_install git
_check_command_and_yum_install rsync
_check_command_and_yum_install createrepo


case $1 in
	status )
		;;

	list )
		List
		;;
	* )
	RUN

	;;
esac



