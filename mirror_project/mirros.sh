#!/bin/bash

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
_source_file_exist ./include/env.sh
_source_file_exist ./include/run.sh
_source_file_exist ./include/static-repo.sh


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

    centos7)
        _rsync_CentOS7
        ;;
    centos6)
        _rsync_CentOS6
        ;;
    epel6 )
        _rsync_EPEL6
        ;;
    epel7 )
        _rsync_EPEL7
        ;;
    mariadb )
        _rsync_mariadb7
        ;;

    zabbix6 )
        _zabbix_6
            ;;
        zabbix7)
            _zabbix_7

            ;;
        glibc )
            _wget_glibc

            ;;
        mongodb)
            _mongodb_3.6
            ;;
        nginx )
            _nginx_centos6
            ;;

        all )
            _rsync_CentOS7
            _rsync_CentOS6
            _rsync_EPEL6
            _rsync_EPEL7
            _rsync_mariadb7
            _rsync_remi_56
            _rsync_remi_72
            _zabbix_6
            _zabbix_7
            _wget_glibc
            _mongodb_3.6
            _nginx_centos6
            _rsync_remi_56_7
            _rsync_remi_72_7
            _rsync_mariadb7
            _rsync_mariadb6
            _rsync_remi_7
            _rsync_remi_6
            ;;
        createrepos )
            _create_repos_file
            _chage_add_repos
            ;;
        server )
            _mirrors_server
            links_for_mirrors
            ;;


        httpd_firewalld )
            _firewalld_httpd
            ;;
        glpi )
            _glpi9.1_centos6
            _glpi9.3_centos6
            ;;
        pinpoint )
            _pinpoint
            ;;
        remi )
            _rsync_remi_6
            _rsync_remi_56_6
            _rsync_remi_72_6
            _rysnc_remi_7
            _rsync_remi_56_7
            _rsync_remi_72_7
            ;;
        * )
            RUN
            ;;
esac
