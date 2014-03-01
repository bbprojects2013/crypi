#!/bin/bash
DEST=/tmp/download


function initinvironment {
 echo "" 
 echo "=== Creating destination dir ===" 
 echo "Install wget"
 apt-get -q update
 apt-get -y install wget curl
 mkdir $DEST
 cd $DEST
}

function download {
 echo ""
 echo "=== Download sources ==="
 wget -c ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.12.tar.bz2
 wget -c ftp://ftp.gnupg.org/gcrypt/libgpg-error/libgpg-error-1.12.tar.bz2.sig
 wget -c ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.1.tar.bz2
 wget -c ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.1.tar.bz2.sig
 wget -c ftp://ftp.gnupg.org/gcrypt/libksba/libksba-1.3.0.tar.bz2
 wget -c ftp://ftp.gnupg.org/gcrypt/libksba/libksba-1.3.0.tar.bz2.sig
 wget -c ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-2.1.1.tar.bz2
 wget -c ftp://ftp.gnupg.org/gcrypt/libassuan/libassuan-2.1.1.tar.bz2.sig
 wget -c https://alioth.debian.org/frs/download.php/file/3989/ccid-1.4.15.tar.bz2
 wget -c https://alioth.debian.org/frs/download.php/file/3990/ccid-1.4.15.tar.bz2.asc
 mv ccid-1.4.15.tar.bz2.asc ccid-1.4.15.tar.bz2.sig
 wget -c ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.0.22.tar.bz2
 wget -c ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.0.22.tar.bz2.sig
}

function verify {
 echo ""
 echo "=== Get Signatur keys ==="
 curl https://raw.github.com/bbprojects2013/crypi/master/sw/installer/sig_keys/pub_key_Werner_Koch.key >pub_key_Werner_Koch.key
 curl https://raw.github.com/bbprojects2013/crypi/master/sw/installer/sig_keys/pub_key_Ludovic_Rousseau.key >pub_key_Ludovic_Rousseau.key
 gpg --import pub_key_Werner_Koch.key
 gpg --import pub_key_Ludovic_Rousseau.key
 rm *.key

 echo ""
 echo "=== Check Sigantures ==="
 for SIGNATURE in $( ls -1 *.sig )
 do 
	 gpg --verify $SIGNATURE
	 EXCODE=$?
     if [ $EXCODE -ne 0 ]; then
         echo ""
         echo "ERROR IN CHECKING SIGNATURE OF FILE $SIGNATURE"    
         echo "Will exit now"
         exit 1
     fi
 done
 rm *.sig
}


function extract {
 echo ""
 echo "=== Extracting files ==="
 find ./ -name "*.bz2" -exec tar xjf {}  \;
 rm *.bz2
 echo "Done"
}

function prepcompile {
  echo ""
  echo "=== Installing build toolchain ==="
  apt-get -y install build-essential automake libtool libpcsclite-dev libgusb-dev flex libudev-dev
  apt-get -y install libpth-dev
}

function postcompile {
  echo ""
  echo "=== Removing build toolchain ==="
  apt-get -y remove build-essential automake libtool libpcsclite-dev libgusb-dev flex libudev-dev
  apt-get -y remove libpth-dev
  apt-get -y autoremove 
  apt-get clean
}

function compile_install {
  THISPATH=$1
  echo ""
  echo "=== Compiling $THISPATH ==="
  cd $THISPATH
  ./configure
  EXCODE=$?
  if [ $EXCODE -ne 0 ]; then
       echo ""
       echo "Error in ./configure step of $THISPATH"    
       echo "Will exit now"
       exit 1
  fi
    
  make
  EXCODE=$?
  if [ $EXCODE -ne 0 ]; then
       echo ""
       echo "Error in make step of $THISPATH"    
       echo "Will exit now"
       exit 1
  fi
  
  make install 
  EXCODE=$?
  if [ $EXCODE -ne 0 ]; then
       echo ""
       echo "Error in make install step of $THISPATH"    
       echo "Will exit now"
       exit 1
  fi
  
  echo "=== Done with compile & install of $THISPATH ==="
  cd $DEST
}

function preparesystem { 
  echo ""
  echo "=== Install other dependencies ==="
  apt-get -y install pcscd pinentry-curses
  echo "pinentry-program /usr/bin/pinentry"  >>~/.gnupg/gpg-agent.conf
}

################################################################################
###			main
################################################################################
initinvironment
download
verify
extract
prepcompile
preparesystem
compile_install libgpg-error-1.12
compile_install libgcrypt-1.6.1
compile_install libksba-1.3.0
compile_install libassuan-2.1.1
compile_install ccid-1.4.15  
ldconfig
compile_install gnupg-2.0.22
postcompile


echo "Installation finished - please reboot now"
