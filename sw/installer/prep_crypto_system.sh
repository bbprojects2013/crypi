#!/bin/bash
#
# this script performs the necessary updates and prepares the system to be used
# for crypto tasks, such as key generation
#

echo ""
echo "== Performing System update =="
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoclean
apt-get clean


echo ""
echo "== create RAM disk =="
mkdir /ramdisk
chmod 777 /ramdisk
echo "tmpfs    /ramdisk    tmpfs    defaults,size=50%      0       0" >>/etc/fstab
mount /ramdisk
echo "Done"

