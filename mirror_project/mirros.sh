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


_source_file_exist ./include/stack.sh
_source_file_exist ./include/main.sh



case $1 in
    status )
        ;;

    check )
    _check_path
    Check_directory
        ;;
    list )
        List
        ;;
      test )
      _rsync_CentOS7

      ;;
    * )
    RUN

    ;;
esac
