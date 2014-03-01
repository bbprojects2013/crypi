#!/bin/bash
#
# This scripts create new signkey in the ramdisk
# generate new masterkey has to be run before
# workflow was taken from here: https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups
# thanks!
#

RAMDISK=/ramdisk
BASEDIR=$RAMDISK/gpgtmp
MYDIR=$BASEDIR/gpg

MASTERKEY_id=$( cat $BASEDIR/masterid )
SIGN_ID=$( cat $BASEDIR/signid )

echo "Master key id: $MASTERKEY_id"
echo "Sign key id $SIGN_ID"


echo ""
echo "=============================================================="
echo "===== We will now create a new encryption key ====="
echo "command: gpg2 --edit-key $MASTERKEY_id"
echo "Please enter:"
echo "> addkey"
echo "> 6"
echo "Afterwards quit and safe!"
echo "=============================================================="
echo ""
echo ""

gpg2 --home $MYDIR --edit-key $MASTERKEY_id


#grep the id  --> must be the last one
THISID=""
for LINE in $( gpg2 --home $MYDIR --list-keys |grep sub|grep "/"|grep -v $SIGN_ID| cut -b 13-20 )
do 
  #echo "$LINE"
  THISID=$( echo $LINE ) 
done
echo "Identified the new encryption key id $THISID"
echo "$THISID" >$BASEDIR/encryptid