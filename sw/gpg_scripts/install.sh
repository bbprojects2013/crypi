#!/bin/bash
#
# copy all scripts to bin dir
#
DEST=/usr/local/sbin


for THISFILE in $( ls -1 *.sh | grep -v install.sh )
do 
   echo "Copy $THISFILE to $DEST"
   cp $THISFILE $DEST/
done
 