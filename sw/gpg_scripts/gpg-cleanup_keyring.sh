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

MASTERKEY_id=$( cat $BASEDIR/masterid )
SIGN_ID=$( cat $BASEDIR/signid )
ENC_ID=$( cat $BASEDIR/encryptid )
MASTERENCRYPTION_ID=$( cat $BASEDIR/masterencryptionid )


echo "Master key id: $MASTERENCRYPTION_ID"
echo "Master Enryption ID: $MASTERKEY_id"
echo "Sign key id $SIGN_ID"
echo "Encrypt key id is $ENC_ID"



echo "Befor we begin - did you use the backup script and move the keys to the cards? (y/n)"
read ANSWER
if [ "$ANSWER" != "y" ];
then
  echo "Please do so!"
  exit 0
fi


echo ""
echo "=============================================================="
echo "===== We will remove the main encryption subkey ====="
echo "select the key $MASTERENCRYPTION_ID with the command key <number>"
echo "issue the command delkey"
echo "then the command save"
echo "=============================================================="
echo ""
echo ""

#gpg2 --home $MYDIR --edit-key $MASTERKEY_id

#echo "exporting the secret subkey $MASTERKEY_id"
#gpg2 --home $MYDIR --export-secret-subkeys $MASTERKEY_id >$BASEDIR/sub.secring


echo ""
echo "=============================================================="
echo "===== We will remove the secret master key ====="
echo "=============================================================="
echo ""
echo ""

gpg2 --home $MYDIR --delete-secret-keys $MASTERKEY_id

echo ""
echo "=============================================================="
echo "===== We will reimport the stripped key                  ====="
echo "=============================================================="
echo ""
echo ""
gpg2 --home $MYDIR  --import < $BASEDIR/sub.secring
rm $BASEDIR/sub.secring


echo ""
echo "=============================================================="
echo "===== Check your keychain                                ====="
echo "=============================================================="
echo ""
echo ""
gpg2 --home $MYDIR --edit-key $MASTERKEY_id



