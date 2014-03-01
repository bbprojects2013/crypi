#!/bin/bash
#
# This scripts cleans the keyring from the masterkey
# generate new masterkey has to be run before
# workflow was taken from here: https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups
# thanks!
#

RAMDISK=/ramdisk
BASEDIR=$RAMDISK/gpgtmp
MYDIR=$BASEDIR/gpg
BACKUP=$BASEDIR/backupbundles

MASTERKEY_id=$( cat $BASEDIR/masterid )
SIGN_ID=$( cat $BASEDIR/signid )
ENC_ID=$( cat $BASEDIR/encryptid )
MASTERENCRYPTION_ID=$( cat $BASEDIR/masterencryptionid )


echo "Master Enryption id: $MASTERENCRYPTION_ID"
echo "Master key ID: $MASTERKEY_id"
echo "Sign key id $SIGN_ID"
echo "Encrypt key id is $ENC_ID"

echo ""
echo "== exporting public keys with id $MASTERKEY_id =="
cp $MYDIR/publickey.asc $BACKUP/publickey.asc
echo "Done"

echo ""
echo "== Writeing gpg-agent.conf =="
echo "pinentry-program /usr/bin/pinentry" >>$MYDIR/gpg-agent.conf
echo "Done"


echo ""
echo "== Create Hashes =="
md5sum $MYDIR/* >$MYDIR/hashes.md5
echo "Done"

echo ""
echo "== Creating backup file =="
cd $BASEDIR/ &&  tar czf $BACKUP/keychains_for_usage.tar.gz ./gpg
echo "Wrote backupfile $BACKUP/keychains_for_usage.tar.gz"
echo "Please use this file at the computer were you want to decrypt"



echo ""
echo "== ALL DONE =="
echo "All data can be found in $BACKUP"
echo "enjoy :-)"








