#!/bin/bash
ROOT=/mnt
DEV=${DEV:-/dev/vda}
BOOTDEV=${DEV}1
LVMDEV=${DEV}2
ROOTDEV=/dev/Main/Root
HOST=${HOST:-void-linux}
REPO=${REPO:-http://repo.voidlinux.com/current}
EXTRAS=${EXTRAS:-"rsync vim tmux socklog-void sv-helper"}
interactive=$1

echo 'Create Partitions, 1 is small (250M), 2 is the rest and LVM (type 8e)'
sfdisk $DEV << EOF
1M,250M,L
,,8e
EOF
sfdisk -l $DEV
if [ -n "$interactive" ];then
	echo -n "Disks look ok? "
	read foo
	if [ -n "$foo" ];then
		echo "Moving On"
	else
		echo "Well, Fix em!"
		fdisk $DEV
	fi
fi

xbps-install -Sy lvm2

pvcreate $LVMDEV
vgcreate -Ay Main $LVMDEV
lvcreate -L5G -n Root Main

mkfs.ext4 $ROOTDEV
mkfs.ext2 $BOOTDEV
mount $ROOTDEV $ROOT
mkdir -p $ROOT/boot
mount $BOOTDEV $ROOT/boot

mkdir $ROOT/dev $ROOT/proc $ROOT/sys
mount --rbind /dev $ROOT/dev
mount --rbind /proc $ROOT/proc
mount --rbind /sys $ROOT/sys


echo YES|xbps-install -r $ROOT -R $REPO -Sy base-voidstrap lvm2

vduuid=$(ls -l /dev/disk/by-uuid/|grep $(basename $BOOTDEV)|awk '{print $9}')
echo "UUID=$vduuid /boot ext2 defaults 0 1" >> $ROOT/etc/fstab
echo "$ROOTDEV / ext4 defaults 0 1" >> $ROOT/etc/fstab

cp /etc/resolv.conf $ROOT/etc/
cp /etc/ssh/moduli $ROOT/etc/ssh/
cp /etc/ssh/ssh_host_* $ROOT/etc/ssh/
printf $HOST > $ROOT/etc/hostname
if [ -n "$interactive" ];then
	echo -n "Choose a root password: "
	read -s RPASSWD
  echo
fi
RPASSWD=${RPASSWD:-none}

cat >$ROOT/tmp/bootstrap.sh <<EOCHROOT
. /etc/profile
sed -i 's/^#en_US/en_US/' /etc/default/libc-locales
echo "root:$RPASSWD"|chpasswd -c SHA512
xbps-reconfigure -f glibc-locales
xbps-install -R $REPO -Sy base-system grub $EXTRAS
[ -d /boot/grub ] || mkdir -p /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
grub-install $DEV
ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default/
ln -s /etc/sv/sshd /etc/runit/runsvdir/default/
EOCHROOT

chroot $ROOT /bin/sh /tmp/bootstrap.sh

umount -a
umount /mnt/dev/pts
umount /mnt/sys
umount /mnt/proc
umount /mnt/dev
umount /mnt
mount
