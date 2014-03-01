/bin/bash
#
# This scripts prepares a raspberry pi system for using the 
# HW random generator in the SOC
#


echo ""
echo "== Preparing system for HW Random usage =="

apt-get update
apt-get -y dist-upgrade
modprobe bcm2708-rng
echo "bcm2708-rng" >>/etc/modules
apt-get install rng-tools
echo "HRNGDEVICE=/dev/hwrng" >>/etc/default/rng-tools
/etc/init.d/rng-tools restart

echo "Done"

