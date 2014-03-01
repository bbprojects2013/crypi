#!/bin/bash
#
# a small script configuring a new system to my usual likeing
#


apt-get update
apt-get -y install joe screen

echo "Set the timezone to Berlin"
cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime


echo "Set German keyboard layout"
echo "# KEYBOARD CONFIGURATION FILE" >/etc/default/keyboard
echo "" >>/etc/default/keyboard
echo "# Consult the keyboard(5) manual page." >>/etc/default/keyboard
echo "" >>/etc/default/keyboard
echo 'XKBMODEL="pc105"' >>/etc/default/keyboard
echo 'XKBLAYOUT="de"' >>/etc/default/keyboard
echo 'XKBVARIANT=""' >>/etc/default/keyboard
echo 'XKBOPTIONS=""' >>/etc/default/keyboard
echo "" >>/etc/default/keyboard
echo 'BACKSPACE="guess"' >>/etc/default/keyboard
