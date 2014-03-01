crypi
=====

This Project is a combination of scripts with the aim for using an embedded system
such as a raspberry pi for security related task such as:

- generating ssl certificates
- generting gpg certificates


A useabe minimal base os image for the raspberry pi can be found here: http://sourceforge.net/projects/minibian/ 

#### Features

* Script which installes GPG2 from the source, including support for OpenPGP Smartcard 
and the Gemalto PC Pinpad USB Reader (http://shop.kernelconcepts.de/product_info.php?cPath=1_26&products_id=122)

* Scripts for creating GPG keys, tranfering them to a OpenPGP Smartcard and seperating the keys. Workflow taken from https://wiki.fsfe.org/Card_howtos/Card_with_subkeys_using_backups

