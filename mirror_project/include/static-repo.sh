#!/bin/bash



function links_for_mirrors(){
    if [ -L /var/www/html/$MIRRORS_WEB ];then
        echo "mirrors links is ok!"
    else
        ln -sf $DATA_DIR /var/www/html
        echo "links now if ok"
    fi

}

function _httpd(){
    _check_command_and_yum_install httpd
    sleep 3
    systemctl enable httpd
    systemctl start httpd
}

function _firewalld_httpd(){
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --reload
    _check_command_and_yum_install httpd
    sleep 3
    chcon -R -t httpd_sys_content_t $DATA_DIR
    systemctl enable httpd
    systemctl start httpd
}


IP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d '/')

function _create_repos_file(){
    cat > $REPO/centos-7.repo << EOF
[base]
name = base
baseurl = http://$IP/$WEB_CentOS7/os/x86_64
enable = 1
gpgcheck = 0

[update]
name = update
baseurl = http://$IP/$WEB_CentOS7/updates/x86_64/
enable = 1
gpgcheck = 0


[extras]
name = extras
baseurl = http://$IP/$WEB_CentOS7/extras/x86_64/
enable = 1
gpgcheck = 0

EOF

    cat > $REPO/centos-6.repo << EOF
[base]
name = base
baseurl = http://$IP/$WEB_CentOS6/os/x86_64
enable = 1
gpgcheck = 0

[update]
name = update
baseurl = http://$IP/$WEB_CentOS6/updates/x86_64
enable = 1
gpgcheck = 0


[extras]
name = extras
baseurl = http://$IP/$WEB_CentOS6/extras/x86_64
enable = 1
gpgcheck = 0
EOF


# EPEL
    cat > $REPO/epel-7.repo << EOF
[epel]
name = epel
baseurl = http://$IP/$WEB_EPEL7/x86_64
enable = 1
gpgcheck = 0

EOF

    cat > $REPO/epel-6.repo << EOF
[epel]
name = epel
baseurl = http://$IP/$WEB_EPEL6/x86_64
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/mongodb-6.repo << EOF
[epel]
name = epel
baseurl = http://$IP/$WEB_MONGODB6
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/mariadb-7.repo << EOF
[mariadb]
name = mariadb
baseurl = http://$IP/$WEB_Mariadb7/x86_64
enable = 1
gpgcheck = 0
EOF
    cat > $REPO/mariadb-6.repo << EOF
[mariadb]
name = mariadb
baseurl = http://$IP/$WEB_Mariadb6/x86_64
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/nginx-6.repo << EOF
[nginx]
name = nginx
baseurl = http://$IP/$WEB_NGINX
enable = 1
gpgcheck = 0
EOF


    cat > $REPO/remi56-6.repo << EOF
[remi]
name = remi
baseurl = http://$IP/$WEB_REMI_6/x86_64
enable = 1
gpgcheck = 0

[remi56]
name = remi56
baseurl = http://$IP/$WEB_REMI_6/56/x86_64
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/remi72-6.repo << EOF

[remi]
name = remi
baseurl = http://$IP/$WEB_REMI_6/x86_64
enable = 1
gpgcheck = 0


[remi72]
name = remi72
baseurl = http://$IP/$WEB_REMI_6/72/x86_64
enable = 1
gpgcheck = 0
EOF
    cat > $REPO/remi56-7.repo << EOF

[remi]
name = remi
baseurl = http://$IP/$WEB_REMI_7/x86_64
enable = 1
gpgcheck = 0

[remi56]
name = remi56
baseurl = http://$IP/$WEB_REMI_7/56/x86_64
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/remi72-7.repo << EOF
[remi]
name = remi
baseurl = http://$IP/$WEB_REMI_7/x86_64
enable = 1
gpgcheck = 0


[remi72]
name = remi72
baseurl = http://$IP/$WEB_REMI_7/72/x86_64
enable = 1
gpgcheck = 0
EOF



    cat > $REPO/zabbix-6.repo << EOF
[zabbix]
name = zabbix
baseurl = http://$IP/$WEB_ZABBIX6/x86_64
enable = 1
gpgcheck = 0

[zabbix-non-supported]
name = non-supported
baseurl = http://$IP/$WEB_ZABBIX6/non-supported/x86_64/
enable = 1
gpgcheck = 0
EOF

cat > $REPO/zabbix-7.repo << EOF

[zabbix]
name = zabbix
baseurl = http://$IP/$WEB_ZABBIX7/x86_64
enable = 1
gpgcheck = 0

[zabbix-non-supported]
name = non-supported
baseurl = http://$IP/$WEB_ZABBIX7/non-supported/x86_64/
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/glibc-6.repo << EOF
[glibc]
name = glibc
baseurl = http://$IP/WEB_GLIBC
enable = 1
gpgcheck = 0
EOF
}
