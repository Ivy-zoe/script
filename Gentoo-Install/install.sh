#!/bin/bash


# env
MIRROR=mirrors.ustc.edu.cn
GENTOO_MIRROR=https://$MIRROR/gentoo
STAGE_MIRROR=$GENTOO_MIRROR/releases/amd64/autobuilds
PORTAGE_MIRROR=rsync://rsync.$MIRROR/gentoo-portage

# lib

function _check_directory(){
         if [  -d $1 ];then
         echo "$1 is ok!"
         else mkdir -p $1
         fi
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

function _exit()
{
exit 9;


CPU=$(grep 'model name' /proc/cpuinfo |wc -l)
##判断用户
if [ `whoami` != root ];then
	echo "please run this script on root"
	_exit
fi

_check_directory /mnt/gentoo


# color

function color(){
	case $1 in 
        red)
            echo -e "\033[31m$2\033[0m"
        ;;
        green)
            echo -e "\033[32m$2\033[0m"
        ;;
    esac
}

function partition(){
    if (echo $1 | grep '/' > /dev/null 2>&1);then
        other=$1
    else
        other=/$1
    fi

    fdisk -l
    color green "Input the partition (/dev/sdaX"
    read OTHER
    color green "Format it ? y)yes ENTER)no"
    read tmp

    if [ "$other" == "/boot" ];then
        boot=$OTHER
    fi

    if [ "$tmp" == y ];then
        umount $OTHER > /dev/null 2>&1
        color green "Input the filesystem's num to format it"
        select type in 'ext2' "ext3" "ext4" "btrfs" "xfs" "jfs" "fat" "swap";do
            case $type in
                "ext2")
                    mkfs.ext2 $OTHER
                    break
                ;;
                "ext3")
                    mkfs.ext3 $OTHER
                    break
                ;;
                "ext4")
                    mkfs.ext4 $OTHER
                    break
                ;;
                "btrfs")
                    mkfs.btrfs $OTHER -f
                    break
                ;;
                "xfs")
                    mkfs.xfs $OTHER -f
                    break
                ;;
                "jfs")
                    mkfs.jfs $OTHER
                    break
                ;;
                "fat")
                    mkfs.fat -F32 $OTHER
                    break
                ;;
                "swap")
                    swapoff $OTHER > /dev/null 2>&1
                    mkswap $OTHER -f
                    break
                ;;
                *)
                    color red "Error ! Please input the num again"
                ;;
            esac
        done
    fi

    if [ "$other" == "/swap" ];then
        swapon $OTHER
    else
        umount $OTHER > /dev/null 2>&1
        mkdir /mnt/gentoo$other
        mount $OTHER /mnt/gentoo$other
    fi
}



function prepare(){
    fdisk -l
    color green "Do you want to adjust the partition ? y)yes ENTER)no"
    read tmp
    if [ "$tmp" == y ];then
        color green "Input the disk (/dev/sdX"
        read TMP
        cfdisk $TMP
    fi
    color green "Input the ROOT(/) mount point:"
    read ROOT
    color green "Format it ? y)yes ENTER)no"
    read tmp
    if [ "$tmp" == y ];then
        umount $ROOT > /dev/null 2>&1
        color green "Input the filesystem's num to format it"
        select type in "ext4" "btrfs" "xfs" "jfs";do
            umount $ROOT > /dev/null 2>&1
            if [ "$type" == "btrfs" ];then
                mkfs.$type $ROOT -f
            elif [ "$type" == "xfs" ];then
                mkfs.$type $ROOT -f
            else
                mkfs.$type $ROOT
            fi
            break
        done
    fi
    mount $ROOT /mnt/gentoo
    color green "Do you have another mount point ? if so please input it, such as : /boot /home and swap or just ENTER to skip"
    read other
    while [ "$other" != '' ];do
        partition $other
        color green "Still have another mount point ? input it or just ENTER"
        read other
    done
}

function _install_file(){
	##安装文件
	read -p "输入y使用openRC 回车使用systemd(如果你使用gnome桌面请务必选择systemd) " INIT
	cd /mnt/gentoo
	rm -f index.html
	if [ "$INIT" == y ];then
		INIT=openrc
		LATEST=$(wget -q $STAGE_MIRROR/current-stage3-amd64/ && grep -o stage3-amd64-.........tar.bz2 index.html | head -1)
		wget $STAGE_MIRROR/current-stage3-amd64/$LATEST
		echo 解压中...
		tar xjpf $LATEST --xattrs --numeric-owner
	else
		INIT=systemd 
		LATEST=$(wget -q $STAGE_MIRROR/current-stage3-amd64-systemd/ && grep -o stage3-amd64-systemd-.........tar.bz2 index.html | head -1)
		wget $STAGE_MIRROR/current-stage3-amd64-systemd/$LATEST
		echo 解压中...
		tar xjpf $LATEST --xattrs --numeric-owner
	fi

	rm $LATEST

	if [ "$BOOT" == y ];then
		umount $boot
		mount -v $boot /mnt/gentoo/boot
	fi
}



function config_make(){

    cat > /mnt/gentoo/etc/portage/make.conf  << EOF
# GCC
CHOST="x86_64-pc-linux-gnu"
CFLAGS="-march=native -O2 -pipe"
CXXFLAGS="${CFLAGS}"
MAKEOPTS=\"-j$CPU\"

# PORTAGE
PORTDIR="/usr/portage"
DISTDIR="${PORTDIR}/distfiles"
PKGDIR="${PORTDIR}/packages"
GENTOO_MIRROR=\"$GENTOO_MIRROR\"

# USE
DEV="git"
FUCK="-systemd -nautilus"
ELSE="python client acl bzip2"
SYSTEM_ARCH="amd64"
USE="${DEV} ${FUCK} ${ELSE} ${SYSTEM_ARCH}"

# LICENSED
ACCEPT_KEYWORDS="amd64"
ACCEPT_LICENSE="*"

# LANGUAGE
L10N="en-US zh-CN en zh"
LINGUAS="en_US zh_CN en zh"

# ELSE
LLVM_TARGETS="X86"
EOF
}

function _video(){
	##Video Cards
	VIDEO=6
	while (($VIDEO!=1&&$VIDEO!=2&&$VIDEO!=3&&$VIDEO!=4&&$VIDEO!=5));do
		echo "输入对应的显卡配置
	[1]  Intel
	[2]  Nvidia
	[3]  Intel/Nvidia
	[4]  AMD/ATI
	[5]  Intel/AMD"
		read VIDEO
		if [ "$VIDEO" == 1 ];then
			echo VIDEO_CARDS=\"intel i965\" >> /mnt/gentoo/etc/portage/make.conf
		elif [ "$VIDEO" == 2 ];then
			echo VIDEO_CARDS=\"nvidia\" >> /mnt/gentoo/etc/portage/make.conf
		elif [ "$VIDEO" == 3 ];then
			echo VIDEO_CARDS=\"intel i965 nvidia\" >> /mnt/gentoo/etc/portage/make.conf
		elif [ "$VIDEO" == 4 ];then
			echo VIDEO_CARDS=\"radeon\" >> /mnt/gentoo/etc/portage/make.conf
		elif [ "$VIDEO" == 5 ];then
			echo VIDEO_CARDS=\"intel i965 radeon\" >> /mnt/gentoo/etc/portage/make.conf
		else echo 请输入正确数字
	fi
	done
}

function _mirrors(){
	_check_directory /mnt/gentoo/etc/portage/repos.conf

cat > /mnt/gentoo/etc/portage/repos.conf/gentoo.conf << EOF

[gentoo]
location = /usr/portage
sync-type = rsync
#sync-uri = rsync://mirrors.tuna.tsinghua.edu.cn/gentoo-portage/
sync-uri = rsync://rsync.mirrors.ustc.edu.cn/gentoo-portage/
auto-sync = yes
EOF
}


##Chroot

function _chroot(){
	mount -t proc /proc /mnt/gentoo/proc
	mount --rbind /sys /mnt/gentoo/sys
	mount --make-rslave /mnt/gentoo/sys
	mount --rbind /dev /mnt/gentoo/dev
	mount --make-rslave /mnt/gentoo/dev
	rm -f /mnt/gentoo/etc/resolv.conf
	cp /etc/resolv.conf /mnt/gentoo/etc/
	cd root/
	wget https://raw.githubusercontent.com/YangMame/Gentoo-Installer/master/Config.sh
	chmod +x Config.sh
	chroot /mnt/gentoo /root/Config.sh $FILESYSTEM $INIT $VIDEO
}

function main(){

}
