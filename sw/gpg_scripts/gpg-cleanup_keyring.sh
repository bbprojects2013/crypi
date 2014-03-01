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


#backup the public keyring
cp $MYDIR/pubring.gpg $BASEDIR/pubring.gpg


echo ""
echo "=============================================================="
echo "===== We will remove the main encryption subkey ====="
echo "select the key $MASTERENCRYPTION_ID with the command key <number>pub"
echo "issue the command delkey"
echo "then the command save"
echo "=============================================================="
echo ""
echo ""

gpg2 --home $MYDIR --edit-key $MASTERKEY_id

echo "exporting the secret subkey $MASTERKEY_id"
gpg2 --home $MYDIR --export-secret-subkeys $MASTERKEY_id >$BASEDIR/sub.secring


echo ""
echo "=============================================================="
echo "===== We will remove the secret master key ====="
echo "please answer the question with yes"
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
gpg2 --home $MYDIR  --import < $BASEDIR/pubring.gpg
rm $BASEDIR/pubring.gpg

echo ""
echo "=============================================================="
echo "===== Check your keychain                                ====="
echo "=============================================================="
echo ""
echo ""
gpg2 --home $MYDIR --edit-key $MASTERKEY_id

echo ""
echo "=============================================================="
echo "===== creating sample gpg.conf                           ====="
echo "=============================================================="
echo ""
echo ""

cp gpg.conf_sample $MYDIR/gpg.conf
echo "hidden-encrypt-to 0x$ENC_ID!" >>$MYDIR/gpg.conf
echo "hidden-encrypt-to 0x$MASTERENCRYPTION_ID!" >>$MYDIR/gpg.conf
echo "default-recipient 0x$ENC_ID!" >>$MYDIR/gpg.conf
echo "default-recipient 0x$MASTERENCRYPTION_ID!" >>$MYDIR/gpg.conf

echo ""
echo "=============================================================="
echo "===== testing encryption                                 ====="
echo "=============================================================="
echo ""
echo ""


echo "If you can read this it is working!" >$BASEDIR/testfile.txt
gpg2 --home $MYDIR -e $BASEDIR/testfile.txt
gpg2 --home $MYDIR -d $BASEDIR/testfile.txt.gpg

echo ""
echo "Please remove the GPG Card"
read ANSWER

echo "Decryption should now not work!"
gpg2 --home $MYDIR -d $BASEDIR/testfile.txt.gpg

rm $BASEDIR/testfile.txt*





