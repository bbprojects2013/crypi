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
ENC_ID=$( cat $BASEDIR/encryptid )

echo "Master key id: $MASTERKEY_id"
echo "Sign key id $SIGN_ID"
echo "Encrypt key id is $ENC_ID"


echo "Checking GPG Card"
gpg2 --home $MYDIR --card-status ||exit 1


echo ""
echo "=============================================================="
echo "===== We will now move the keys to the card ====="
echo "use the command 'toggle' to switch to the secret keys"
echo "select the key $SIGN_ID with the command key <number>"
echo "issue the command keytocard"
echo "Then select 'Signature key'"
echo "repeate the steps with the encryption key $ENC_ID"
echo "Afterwards quit and safe!"
echo "=============================================================="
echo ""
echo ""

gpg2 --home $MYDIR --edit-key $MASTERKEY_id


