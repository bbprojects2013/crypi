crypi
=====

This Project is a combination of scripts with the aim for using an embedded system
such as a raspberry pi for security related task such as:

- generating ssl certificates
- generating gpg certificates


A useable minimal base os image for the raspberry pi can be found here: http://sourceforge.net/projects/minibian/ 

#### Features

* Script which installs GPG2 from the source, including support for OpenPGP Smart card 
and the Gemalto PC Pinpad USB Reader (http://shop.kernelconcepts.de/product_info.php?cPath=1_26&products_id=122)

* Scripts for creating GPG keys, transferring them to a OpenPGP Smart card and separating the keys. Workflow taken from https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups

