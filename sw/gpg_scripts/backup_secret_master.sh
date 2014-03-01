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

MASTERKEY_id=$( cat $BASEDIR/masterid )
SIGN_ID=$( cat $BASEDIR/signid )
ENC_ID=$( cat $BASEDIR/encryptid )
MASTERENCRYPTION_ID=$( cat $BASEDIR/masterencryptionid )


echo "Master key id: $MASTERENCRYPTION_ID"
echo "Master Enryption ID: $MASTERKEY_id"
echo "Sign key id $SIGN_ID"
echo "Encrypt key id is $ENC_ID"


echo ""
echo "== exporting public keys with id $MASTERKEY_id =="
echo "Writing file $MYDIR/publickey.asc"
echo "Fingerprint:" >$MYDIR/publickey.asc
gpg2 --home $MYDIR --fingerprint >>$MYDIR/publickey.asc
echo "">>$MYDIR/publickey.asc
gpg2 --home $MYDIR --armor --export $MASTERKEY_id >>$MYDIR/publickey.asc


################### generate revoke start  ###############
echo ""
echo "== Generate revoke certs =="

echo "Keys (public):" >$MYDIR/revoke_certificates.txt
gpg2 --home $MYDIR --list-keys >>$MYDIR/revoke_certificates.txt

echo "" >>$MYDIR/revoke_certificates.txt
echo "Keys (privat):" >>$MYDIR/revoke_certificates.txt
gpg2 --home $MYDIR --list-secret-keys >>$MYDIR/revoke_certificates.txt


echo "" >>$MYDIR/revoke_certificates.txt
echo "Key: $MASTERENCRYPTION_ID" >>$MYDIR/revoke_certificates.txt
gpg2 --home $MYDIR --armor --gen-revoke $MASTERENCRYPTION_ID >>$MYDIR/revoke_certificates.txt

echo "" >>$MYDIR/revoke_certificates.txt
echo "Key: $SIGN_ID" >>$MYDIR/revoke_certificates.txt
gpg2 --home $MYDIR --armor --gen-revoke $SIGN_ID >>$MYDIR/revoke_certificates.txt

echo "" >>$MYDIR/revoke_certificates.txt
echo "Key: $ENC_ID" >>$MYDIR/revoke_certificates.txt
gpg2 --home $MYDIR --armor --gen-revoke $ENC_ID >>$MYDIR/revoke_certificates.txt

echo "" >>$MYDIR/revoke_certificates.txt
echo "Key: $MASTERKEY_id" >>$MYDIR/revoke_certificates.txt
gpg2 --home $MYDIR --armor --gen-revoke $MASTERKEY_id >>$MYDIR/revoke_certificates.txt
################### generate revoke end  ###############

echo ""
echo "== Create Hashes =="
md5sum $MYDIR/* >$MYDIR/hashes.md5


#backup the file
mkdir -p $BACKUP
cd $BASEDIR/ &&  tar czf $BACKUP/secret_master_key.tar.gz ./gpg
echo "Wrote backupfile $BACKUP/secret_master_key.tar.gz"
