#!/bin/bash
#
# This scripts create new signkey in the ramdisk
# generate new masterkey has to be run before
# workflow was taken from here: https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups
# thanks!
#

RAMDISK=/ramdisk
MYDIR=$RAMDISK/gpg
$RAMDISK/masterid.sh

echo ""
echo "=============================================================="
echo "===== We will now create a new signing key ====="
echo "command: gpg2 --edit-key $MASTERKEY_id"
echo "Please enter:"
echo "addkey"
echo "I recomment you mark this key with sign key in the comment"
echo "=============================================================="
echo ""
echo ""

gpg2 --home $MYDIR --edit-key $MASTERKEY_id
