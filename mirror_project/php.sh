#=============================================================
#=============================================================
# ================ PHP for CentOS6 ===========================
#=============================================================
#=============================================================
## REMI for CentOS6
function _rsync_remi_6(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/remi/x86_64/ $REMI6/x86_64/
    _update_repos $REMI6/x86_64/
}

## REMI PHP Test
## CentOS6
function _rsync_remi_6_test(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/test/x86_64 $REMI6/test
    _update_repos $REMI6/test
}

## REMIE PHP 56
## CentOS6 Only sync x86_64 basearch
function _rsync_remi_6_56(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/php56/x86_64/ $REMI6/php56/
    _update_repos $REMI6/php56/
}
## REMI PHP 56 debuginfo
function _rsync_remi6_php56_debuginfo(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/debug-php56/x86_64 $REMI6/debug-php56
    _update_repos $REMI6/debug-php56
}

## REMI 56 test
## CentOS6 Only rsync x86_64 basearch
function _rsync_remi6_php56_test(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/test56/x86_64 $REMI6/test56
    _update_repos $REMI6/test56
}
## REMI 56 test info
## CentOS6 Only sync x86_64 basearch
function _rsync_remi6_php56_test_info(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/debug-test56/x86_64 $REMI6/debug-test56
    _update_repos $REMI6/debug-test56
}


## REMI PHP 72
## CentOS6
function _rsync_remi_6_72(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/remi72/x86_64/ $REMI6/php72
    _update_repos $REMI6/php72
}
## REMI 72 debuginfo
## CentOS6 Only rsync x86_64 basearch
function _rsync_remi6_php72_debuginfo(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/debug-php72/x86_64 $REMI6/debug-php72
    _update_repos $REMI/debug-php72
}
## REMI 72 test
## CentOS6 Only rsync x86_64 basearch
function _rsync_remi6_php72_test(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/test72/x86_64 $REMI6/test72
    _update_repos $REMI6/test72
}
## REMI 72 test info
## CentOS6 Only sync x86_64 basearch
function _rsync_remi6_php72_test_info(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/6/debug-test72/x86_64 $REMI6/debug-test72
    _update_repos $REMI6/debug-test72
}


#=============================================================
#=============================================================
# ================ PHP for CentOS7 ===========================
#=============================================================
#=============================================================


## REMI PHP Test
## CentOS7 Only Rsync x86_64

## REMI for CentOS7
function _rysnc_remi_7(){
    _rsync_mirrors $Config_DIR/remi.list  $rsync_tuna/remi/enterprise/7/remi/x86_64 $REMI7/x86_64
    _update_repos $REMI7/x86_64
}


function _rsync_remi_7_test(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/test/x86_64 $REMI7/test
    _update_repos $REMI7/test
}


## REMI PHP 56 For CentOS7
## Only sync basearch x86_64
function _rsync_remi_56_7(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/php56/x86_64/ $REMI7/56
    _update_repos $REMI7/56/
}
## REMI PHP56 for CentOS7  Test
## Only sync basearch
function _rsync_remi_56_7_test(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/test56/x86_64 $REMI7/test56
    _update_repos $REMI7/test56
}

## REMI PHP56 info
## Only sync basearch
function _rsync_remi_56_7_info(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/debug-php56/x86_64 $REMI7/debug-php56
    _update_repos $REMI7/debug-php56
}
## REMI PHP56 TestInfo
## Only sync basearch
function _rsync_remi_56_7_testinfo(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/debug-test56/x86_64/ $REMI7/debug-test56
    _update_repos $REMI7/debug-test56
}
## REMI PHP 72 
function _rsync_remi_72_7(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/php72/x86_64/ $REMI7/72
    _update_repos $REMI7/72
}

function _rsync_remi_72_7_test(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/test72/x86_64 $REMI7/test72
    _update_repos $REMI7/test72
}

## REMI PHP72 info
## Only sync basearch
function _rsync_remi_72_7_info(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/debug-php72/x86_64 $REMI7/debug-php72
    _update_repos $REMI7/debug-php72
}
## REMI PHP72 TestInfo
## Only sync basearch
function _rsync_remi_72_7_testinfo(){
    _rsync_mirrors $Config_DIR/remi.list $rsync_tuna/remi/enterprise/7/debug-test72/x86_64/ $REMI7/debug-test72
    _update_repos $REMI7/debug-test72
}

###############
###### man ####
###############


function _check_dir(){
    _check_directory $REMI6/x86_64/
    _check_directory $REMI6/test
    _check_directory $REMI6/php56/
    _check_directory $REMI6/debug-php56
    _check_directory $REMI6/test56
    _check_directory $REMI6/debug-test56
    _check_directory $REMI6/php72
    _check_directory $REMI/debug-php72
    _check_directory $REMI6/test72
    _check_directory $REMI6/debug-test72
    _check_directory $REMI7/x86_64
    _check_directory $REMI7/test
    _check_directory $REMI7/56/
    _check_directory $REMI7/test56
    _check_directory $REMI7/debug-php56
    _check_directory $REMI7/debug-test56
    _check_directory $REMI7/72
    _check_directory $REMI7/test72
    _check_directory $REMI7/debug-php72
    _check_directory $REMI7/debug-test72
}

function repo_file(){
    cat > $REPO/remi-6.repo << EOF
[remi]
name = remi6
baseurl = http://$IP/$WEB/remi/6/x86_64
enable = 1
gpgcheck = 0

[remi-test]
name = remi6 Test
baseurl = http://$IP/$WEB/remi/6/test
enable = 1
gpgcheck = 0


EOF
    cat > $REPO/remi56-6.repo << EOF
[remi56]
name = remi56
baseurl = http://$IP/$WEB/remi/6/php56
enable = 1
gpgcheck = 0


[remi56-debug]
name = remi56 debug
baseurl = http://$IP/$WEB/remi/6/debug-php56
enable = 1
gpgcheck = 0

[remi56-test]
name = remi56 test
baseurl = http://$IP/$WEB/remi/6/test56
enable = 1
gpgcheck = 0

[remi56-debug-test]
name = remi56 debug test
baseurl = http://$IP/$WEB/remi/6/debug-test56
enable = 1
gpgcheck = 0


EOF

    cat > $REPO/remi72-6.repo << EOF
[remi72]
name = remi72
baseurl = http://$IP/$WEB/remi/6/72/
gpgcheck = 0

[remi72-debug]
name = remi56 debug
baseurl = http://$IP/$WEB/remi/6/debug-php72
enable = 1
gpgcheck = 0

[remi72-test]
name = remi72 test
baseurl = http://$IP/$WEB/remi/6/test72
enable = 1
gpgcheck = 0

[remi72-debug-test]
name = remi72 debug test
baseurl = http://$IP/$WEB/remi/6/debug-test72
enable = 1
gpgcheck = 0

EOF

    cat > $REPO/remi-7.repo << EOF

[remi]
name = remi7
baseurl = http://$IP/$WEB/remi/7/x86_64
enable = 1
gpgcheck = 0

[remi-test]
name = remi7 test
baseurl = http://$IP/$WEB/remi/7/test
enable = 1
gpgcheck = 0

EOF
    cat > $REPO/remi56-7.repo << EOF


[remi56]
name = remi56
baseurl = http://$IP/$WEB/remi/7/php56
enable = 1
gpgcheck = 0


[remi56-debug]
name = remi56 debug
baseurl = http://$IP/$WEB/remi/7/debug-php56
enable = 1
gpgcheck = 0

[remi56-test]
name = remi56 test
baseurl = http://$IP/$WEB/remi/7/test56
enable = 1
gpgcheck = 0

[remi56-debug-test]
name = remi56 debug test
baseurl = http://$IP/$WEB/remi/7/debug-test56
enable = 1
gpgcheck = 0
EOF

    cat > $REPO/remi72-7.repo << EOF
[remi72]
name = remi72
baseurl = http://$IP/$WEB/remi/7/72/
gpgcheck = 0

[remi72-debug]
name = remi56 debug
baseurl = http://$IP/$WEB/remi/7/debug-php72
enable = 1
gpgcheck = 0

[remi72-test]
name = remi72 test
baseurl = http://$IP/$WEB/remi/7/test72
enable = 1
gpgcheck = 0

[remi72-debug-test]
name = remi72 debug test
baseurl = http://$IP/$WEB/remi/7/debug-test72
enable = 1
gpgcheck = 0
EOF

}
function PHP(){
    _check_dir
    _rsync_remi_6
    _rsync_remi_6_test
    _rsync_remi_6_56
    _rsync_remi6_php56_debuginfo
    _rsync_remi6_php56_test
    _rsync_remi6_php56_test_info
    _rsync_remi_6_72
    _rsync_remi6_php72_debuginfo
    _rsync_remi6_php72_test
    _rsync_remi6_php72_test_info
    _rysnc_remi_7
    _rsync_remi_7_test
    _rsync_remi_56_7
    _rsync_remi_56_7_test
    _rsync_remi_56_7_info
    _rsync_remi_56_7_testinfo
    _rsync_remi_72_7
    _rsync_remi_72_7_test
    _rsync_remi_72_7_info
    _rsync_remi_72_7_testinfo
    repo_file
}
