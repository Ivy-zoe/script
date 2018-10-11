function Check_Software(){
    type rsync >/dev/null 2>&1 || { echo >&2 "I require rsync but it's not installed.  Aborting."; yum install rsync -y; }
    type createrepo >/dev/null 2>&1 || { echo >&2 "I require createrepo but it's not installed.  Aborting."; yum install createrepo -y; }
}
# check dir
function Check_Work_Dir(){
    if [ -d $WORK_DIR ]; then echo work_dir_is_ok! ; else `mkdir -p $WORK_DIR`  `cp -r ./config $WORK_DIR` ; fi

}
# Check Data Dir
function Check_Data_Dir(){
    if [ -d $DATA_DIR ]; then echo data_dir_is_ok! ; else mkdir -p $DATA_DIR ; fi
}
function Check_Mirros_Dir(){
    if [ -d $EPEL6 ]; then echo mirrors_dir_is_ok! ; else `mkdir -p $EPEL6` `mkdir -p $EPEL7` `mkdir -p $CentOS7` `mkdir -p $CentOS6` `mkdir -p $MONGODB` `mkdir -p $Mariadb` `mkdir -p $Nginx` `mkdir -p $REMI` `mkdir -p $ZABBIX6` `mkdir -p $ZABBIX7` `mkdir -p $GLIBC`; fi
}