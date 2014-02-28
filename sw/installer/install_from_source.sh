#!/bin/bash
DEST=/tmp/download


echo "=== Creating destination dir ===" 
mkdir $DEST
cd $DEST

echo "=== Download sources ==="
wget ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.12.tar.bz2
wget ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.12.tar.bz2.sig
wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.1.tar.bz2
wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.1.tar.bz2.sig
wget ftp://ftp.gnupg.org/gcrypt/libksba/libksba-1.3.0.tar.bz2
wget ftp://ftp.gnupg.org/gcrypt/libksba/libksba-1.3.0.tar.bz2.sig
wget ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-2.1.1.tar.bz2
wget ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-2.1.1.tar.bz2.sig
wget https://alioth.debian.org/frs/download.php/file/3989/ccid-1.4.15.tar.bz2
wget https://alioth.debian.org/frs/download.php/file/3990/ccid-1.4.15.tar.bz2.asc
mv ccid-1.4.15.tar.bz2.asc ccid-1.4.15.tar.bz2.sig
wget ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.0.22.tar.bz2
wget ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.0.22.tar.bz2.sig

echo "=== Get Signatur keys ==="
wget https://raw.github.com/bbprojects2013/crypi/master/sw/installer/sig_keys/pub_key_Werner_Koch.key
wget https://raw.github.com/bbprojects2013/crypi/master/sw/installer/sig_keys/pub_key_Ludovic_Rousseau.key
gpg --import pub_key_Werner_Koch.key
gpg --import pub_key_Ludovic_Rousseau.key
rm *.key

echo "=== Check Sigantures ==="