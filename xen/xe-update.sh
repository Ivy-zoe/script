#!/bin/bash

## functions 
function _check_directory(){
         if [  -d $1 ];then
         echo "$1 is ok!"
         else mkdir -p $1
         fi
}

## check env
## Time
DAY=`date  +%Y-%m-%d`
## Backup dir
BACKUP=/backup
## kernel version
KERNEL=$(uname -r)
MODULES=/lib/modules/
## backup modules
MODE_NAME=/tmp/mod-name
function info(){
	echo "please type backup modules name"
	read "TMP"
	echo $TMP > $MODE_NAME
	modinfo $TMP >/tmp/mod-info-old
}
### backup dir

function check(){
	_check_directory $BACKUP/$DAY-old/
	_check_directory $BACKUP/$DAY-new/
}

### backup modules.dep !
function backup_modules(){
#	cp $MODULES$KERNEL/modules.dep $BACKUP/$DAY-old/modules.dep
#	cp $MOD_TMP $BACKUP/$DAY-old/
	cp  -rf $MODULES$KERNEL /$BACKUP/$DAY-old
	echo "Backup old modules is  ok!"
#	cp -rf $MODULES$KERNEL $BACKUP/$DAY-old
#	ls -R $BACKUP/$DAY-old
	
}

## update modules

function update(){
	echo 'update start now !'
	rmmod $(cat $MODE_NAME)
	echo "please type update mode files "
	read "UPDATE_TMP"
	xe update-upload file-name=$UPDATE_TMP
	echo "The UUID of the update is returned when the upload completes,Please input"
	read "UUID_TMP"
	xe update-apply uuid=$UUID_TMP
	echo "now update is ok!"
	modinfo $(cat $MODE_NAME) > /tmp/mod-info-new
#	cat /tmp/mod-info-new
#	cp $MODULES$KERNEL/modules.dep $BACKUP/$DAY-new/modules.dep
#	cp $MOD_NEW $BACKUP/$DAY-new/
	cp -rf $MODULES$KERNEL $BACKUP/$DAY-new
	ls -R $BACKUP/$DAY-new	
	echo "backup files is ok!"
}
## Rollback modules

function rollback(){
	echo "rollback now"
	echo "Please type you want rollback path"
	read "TMP"
	cp -r $BACKUP/$DAY-old/$KERNEL/modules.dep $MODULES$KERNEL
	rm -rf $(cat /tmp/mod-info-new |grep filename |awk '{print $2}')
	depmod
#	rmmod $MODE_NAME
	echo "now is resize"
}

# vs
# diff
## menu
case $1 in

	info )
		info
		;;
	backup )
		check
#		info
		backup_modules
		;;
	update )
		update
		;;
	rollback )
		rollback
		;;
	*)
	echo "backup !"
	;;
esac

