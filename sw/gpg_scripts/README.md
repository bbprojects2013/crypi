Usage
=====

The scripts in this directory allow to create a complete new key, transferring the key to a smart card. Separating the keys (public/private) and also 
creating files which contain the backup. The scripts should be called in the following order:

1) gpg-gen_new_master_key.sh
2) gpg-gen_sign_key.sh
3) gpg-gen_enc_key.sh
4) backup_secret_master.sh
5) gpg-move_key_to_card.sh
6) gpg-cleanup_keyring.sh
7) gpg-wrapup.sh
8) (optional) import the file publickey.asc in your current system, sign the key with your old GPG key and send this key to key servers

Workflow was taken from https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups