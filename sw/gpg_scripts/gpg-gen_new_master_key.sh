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

### check the time
echo "Befor we begin - lets check the time. Is it: $( date )? (y/n)"
read DATECORRECT
#echo "Aswer: $DATECORRECT"
if [ "$DATECORRECT" != "y" ];
then
  echo "Please set the time"
  echo "This can be done with the following command"
  echo 'date -s "2 OCT 2006 18:00:00"'
  exit 0
fi

###generate the keyring files
gpg2 --home $MYDIR --list-keys >/dev/null

echo ""
echo "=============================================================="
echo "===== I will now create a new master key ====="
echo "Recommendation: Never expires and make it long"
echo "This key will NOT be used in normal operation"
echo "and should be kept with a airgap at all time"
echo "Please enter:"
echo "> 1"
echo "=============================================================="
echo ""
echo ""

###gen the keys
gpg2 --home $MYDIR --gen-key

export MASTERKEY_id=$( gpg2 --home $MYDIR --list-secret-keys |grep sec|grep -v ".gpg"| cut -b 13-20 )
echo "$MASTERKEY_id" >$BASEDIR/masterid
echo "Master key id is $MASTERKEY_id"

#grep the master encryption id  --> must be the last one
THISID=""
for LINE in $( gpg2 --home $MYDIR --list-keys |grep sub|grep "/"| cut -b 13-20 )
do 
  #echo "$LINE"
  THISID=$( echo $LINE ) 
done
echo "Identified the master encryption subkey id $THISID"
echo "$THISID" >$BASEDIR/masterencryptionid
