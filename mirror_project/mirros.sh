#!/bin/bash
########### function start ##########
#####################################
#####################################
function _exit()
{
exit 9;
}

function _wget_url()
{
wget -c $1 > /dev/null 2>&1
}

function _check_dir_file_exist()
{
	if [ -e $1 ]; then
		echo "Check $1 ok."
		return 0
		else
		echo "Check $1 Not Found!!!"
		return 1
	fi
}

function _rsync_mirrors()
{
rsync -avz  --exclude-from=$1 $2  $3
}


function _source_file_exist()
{
	if [ -e $1 ]; then
		echo "Check $1 ok."
		source $1
		return 0
		else
		echo "Check $1 Not Found!!!"
		return 1
	fi
}


function _check_command_and_yum_install(){
    type $1 >/dev/null 2>&1 || { echo >&2 "I require $1 but it's not installed.  Aborting."; yum install $1 -y; }
}

function _check_process()
{
pgrep $1 > /dev/null
}

function _blackcolor {
    echo -e "\033[32m$1\033[0m"
}
function _redcolor {
    echo -e "\033[31m$1\033[0m"
}
function _greencolor {
    echo -e "\033[32m$1\033[0m"
}
function _bluecolor {
    echo -e "\033[34m$1\033[0m"
}
function _purplecolor {
    echo -e "\033[35m$1\033[0m"
}
function _skybluecolor {
    echo -e "\033[36m$1\033[0m"
}


function _update_repos(){
	if [ -d $1/repodate ]; then
		createrepo --update $1
	else
		createrepo $1
	fi

}

function _wget_incloud_file(){
		wget --input-file=$1 --continue --directory-prefix=$2
}

function _check_directory(){
         if [  -d $1 ];then
         echo "$1 is ok!"
         else mkdir -p $1
         fi
}

#########################
### funciton end#########
#########################

#########################
####### Incloud files####
#########################

_source_file_exist stack.sh
_source_file_exist static-repo.sh
_source_file_exist php.sh

#########################
####### Incloud end######
#########################




#######################
####### env config ####
#######################
# env config
Config_DIR=./config
DATA_DIR=/data/mirrors
#DATA_DIR=/Users/chaos/Desktop/tmp
#EPEL
EPEL6=$DATA_DIR/epel/6
EPEL7=$DATA_DIR/epel/7
# CentOS
CentOS7=$DATA_DIR/centos/7
CentOS6=$DATA_DIR/centos/6
# Cloud
Rocky=$CentOS7/cloud
# Mongodb
MONGODB6=$DATA_DIR/mongodb/6
MONGODB7=$DATA_DIR/mongodb/7
# Mariadb
Mariadb7=$DATA_DIR/mariadb/7
Mariadb6=$DATA_DIR/mariadb/6
# Nginx
Nginx6=$DATA_DIR/nginx/6
Nginx7=$DATA_DIR/nginx/7
# REMI
REMI6=$DATA_DIR/remi/6
REMI7=$DATA_DIR/remi/7
# zabbix
ZABBIX6=$DATA_DIR/zabbix/6
ZABBIX7=$DATA_DIR/zabbix/7
# Glibc
GLIBC=$DATA_DIR/glibc/6

# pinpoint
pinpoint=$DATA_DIR/pinpoint
# Repos
REPO=$DATA_DIR/repo
# Glpi
GLPI_91=$DATA_DIR/glpi/6/91
GLPI_93=$DATA_DIR/glpi/6/93
# DOCKER
DOCKER=$DATA_DIR/docker
#### ------------
#### ------------
#### ------------
#### ---WEB------
WEB=mirrors

## END

function Check_directory(){
    _check_directory $DATE_DIR
    _check_directory $CentOS7/os/x86_64
    _check_directory $CentOS7/updates/x86_64/
    _check_directory $CentOS7/extras/x86_64/
    _check_directory $CentOS6/os/x86_64
    _check_directory $CentOS6/updates/x86_64
    _check_directory $CentOS6/extras/x86_64
    _check_directory $EPEL6/x86_64/
    _check_directory $EPEL7/x86_64
    _check_directory $Mariadb7/x86_64
    _check_directory $Mariadb6/x86_64
    _check_directory $ZABBIX6/x86_64/
    _check_directory $ZABBIX6/non-supported/x86_64/
    _check_directory $ZABBIX7/x86_64/
    _check_directory $ZABBIX7/non-supported/x86_64/
    _check_directory $GLIBC
    _check_directory $MONGODB6
    _check_directory $MONGODB7
    _check_directory $Nginx6
    _check_directory $Nginx7 
    _check_directory $REPO
    _check_directory $GLPI_91
    _check_directory $GLPI_93
    _check_directory $pinpoint
    _check_directory $Rocky
    _check_directory $DOCKER
}

# rsync_url
rsync_tuna=rsync://mirrors.tuna.tsinghua.edu.cn
function _check_path(){
    _check_command_and_yum_install  rsync
    _check_command_and_yum_install  createrepo
    _check_command_and_yum_install wget
}

###### env config end#########
###############################

############ RUN #############
##############################
#!/bin/bash

function List(){
    clear
    echo "+---------------------------------------------------------------------------------------+"
    echo "| Number  images_command    Website                      Local_Path           "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 1       epel6         $rsync_tuna        $EPEL6   "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 2       epel7         $rsync_tuna        $EPEL7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 3       centos7       $rsync_tuna        $CentOS7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 4       centos6       $rsync_tuna        $CentOS6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 5       mariadb   $rsync_tuna        $DATA_DIR/mariadb"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 6       remi           $rsync_tuna       $DATA_DIR/remi"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 7       mongodb     $rsync_tuna        $MONGODB6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 8       zabbix6       $rsync_tuna        $ZABBIX6"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 9      zabbix7       $rsync_tuna         $ZABBIX7"
    echo "+---------------------------------------------------------------------------------------+"
    echo "|                 Wget "
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 10      glibc        $REDSLEVE         $GLIBC"
    echo "+---------------------------------------------------------------------------------------+"
    echo "| 11       nginx         $USTC        $Nginx "
    echo "+---------------------------------------------------------------------------------------+"
}

function RUN(){
    clear
    echo "+------------------------------------------------------------------------+"
    echo "|                   Rsync Script          "
    echo "+------------------------------------------------------------------------+"
    echo "| This script is only allowed to execute on the CentOS system"
    echo "+------------------------------------------------------------------------+"
    echo "|         Rsync base packages mirrors     "
    echo "+------------------------------------------------------------------------+"
    echo "|           For more information please visit docs                 "
    echo "+------------------------------------------------------------------------+"
    echo "| If you are running for the first time, check your environment with the check option."
    echo "| You can use the list to see which images can be synchronized."
    echo "+------------------------------------------------------------------------+"
    echo "|Use the corresponding image name to sync, or use all to sync all"
    echo "+------------------------------------------------------------------------+"
}

###############################
########### RUN END ###########
###############################



#############################
####### Config file##########
#############################
function _check_config(){
        if [ -d config ];then
            echo "config direcrory is ok"
        else 
            mkdir -pv config
            curl -LO https://raw.githubusercontent.com/slmoby/script/master/mirror_project/config/CurlConfigFile && bash -x CurlConfigFile 
        fi
}

function _check_add(){
        if [ -f add.sh ];then
            echo "add.sh is done"
        else
            curl -LO https://raw.githubusercontent.com/slmoby/script/master/mirror_project/add.sh
        fi
}

### Download file end 
#######################
##### Menu ############
#######################
#######################
case $1 in
    status )
        ;;
    check )
    _check_path
    _check_config
    Check_directory
    _check_add
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
        _rsync_mariadb6
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
            _mongodb_3.6_6
            _mongodb_3.6_7
            ;;
    nginx )
            _nginx_centos6
            _nginx_centos7
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
    remi )
            PHP
            ;;
    rocky )
            _openstack_r
            ;;
    docker )
			_docker_ce
			;;
	all	)
		docker
		nginx
		glibc
		mongodb
		centos6
		centos7
		epel7
		epel6
		zabbix7
		zabbix6
		mariadb
			;;
        * )
            RUN
            ;;
esac
