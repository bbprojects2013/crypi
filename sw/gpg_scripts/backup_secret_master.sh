#!/bin/bash
#
# This scripts backups the secret masterkey files
# workflow was taken from here: https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups
# thanks!
#

RAMDISK=/ramdisk
BASEDIR=$RAMDISK/gpgtmp
MYDIR=$BASEDIR/gpg
BACKUP=$BASEDIR/backupbundles


#backup the file
mkdir -p $BACKUP
cd $BASEDIR/ &&  tar czf $BACKUP/secret_master_key.tar.gz ./gpg
echo "Wrote backupfile $BACKUP/secret_master_key.tar.gz"
