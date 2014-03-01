#!/bin/bash
#
# This scripts create new keyring in the ramdisk and a new master key
# workflow was taken from here: https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups
# thanks!
#

RAMDISK=/ramdisk
BASEDIR=$RAMDISK/gpgtmp
MYDIR=$BASEDIR/gpg
BACKUP=$BASEDIR/backupbundles

mkdir -p $BASEDIR
cd $BASEDIR
rm -fr *
mkdir -p $MYDIR
chmod 700 $MYDIR

gpg2 --home $MYDIR --list-keys

echo ""
echo "=============================================================="
echo "===== I will now create a new master key ====="
echo "Recommendation: Never expires and make it long"
echo "This key will NOT be used in normal operation"
echo "and should be kept with a airgap at all time"
echo "I recomment you mark this key with master key in the comment"
echo "Please enter:"
echo "> 1"
echo "=============================================================="
echo ""
echo ""

gpg2 --home $MYDIR --gen-key

export MASTERKEY_id=$( gpg2 --home $MYDIR --list-secret-keys |grep sec|grep -v ".gpg"| cut -b 13-20 )
echo "$MASTERKEY_id" >$BASEDIR/masterid
echo "Master key id is $MASTERKEY_id"


#backup the file
mkdir -p $BACKUP
cd $BASEDIR/ &&  tar czf $BACKUP/secret_master_key.tar.gz ./gpg