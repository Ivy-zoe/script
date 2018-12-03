#!/bin/bash

# by chaos
# date Mon Dec  3 19:13:37 CST 2018
if [ "$(whoami | id -u)" == "0" ]
then
    echo "run user is root!";
else
	echo "Please use	 root run this script!"
	exit 9
fi

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




_check_dir_file_exist host

# env
HOSTLIST=`cat host`
TP_NAME=chaos
DISK_DIR=/data/kvm/disk
SNAPSHOT=init
# main


function _create_vm(){
	for host in ${HOSTLIST[@]}; do 
		sudo virt-clone -o $TP_NAME -n ${host}  -f $DISK_DIR/${host}.qcow2
done
}

	

function _start_vm(){
	for host in ${HOSTLIST[@]};do 
		sudo virsh start ${host} 
done
}

function _shutdown_vm(){
	for host in ${HOSTLIST[@]};do 
		sudo virsh shutdown ${host} 
done
}

function _remove_vm(){
	for host in ${HOSTLIST[@]};do 
		sudo virsh destroy ${host} 
done
	for host in ${HOSTLIST[@]};do 
		sudo virsh undefine ${host} 
done
	for host in ${HOSTLIST[@]};do 
		sudo rm  -rf $DISK_DIR/${host}.qcow2
done
}

function _resize_vm(){
	for host in ${HOSTLIST[@]}; do 
	sudo virsh snapshot-revert --domain ${host} $SNAPSHOT
done
}

function _create_snapshot(){
	for host in ${HOSTLIST[@]}; do 
	sudo virsh snapshot-create-as --name $SNAPSHOT  ${host}
done
}

function _remove_snapshot(){
	for host in ${HOSTLIST[@]}; do 
	sudo virsh snapshot-delete  ${host} $SNAPSHOT
done	
}

function _vm_info(){
	for host in ${HOSTLIST[@]}; do 
	sudo virsh dominfo ${host} 
done

}

function _vm_ip_show_dhcp(){
	for host in ${HOSTLIST[@]}; do 
	sudo virsh domifaddr ${host}
done
}
case $1 in
	start )
		_start_vm
		;;
	remove )
		_remove_vm
		;;
	resize )
		_resize_vm
		;;
	create )
		_create_vm
		;;
	vminfo )
		_vm_info
		;;
	vmip )
		_vm_ip_show_dhcp
		;;
	create_snapshot )
		_create_snapshot
		;;
	remove_snapshot )
		_remove_snapshot
		;;
	shutdown )
		_shutdown_vm
		;;
	* ) 
		echo "Please type start,remove,resize,create,vminfo,vmip,create_snapshot,remove_snapshot !"
		;;
esac
