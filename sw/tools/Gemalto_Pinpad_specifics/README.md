Gemalto Pinpad Sepcifics
=====

This directory contains some specific file for getting a Gemalto Pinpad smartcard reader up and running.
This was testet with the following reader:

Brand: Gemalto

Name: Gemalto PC Pinpad USB Reader 

USB ID: <will folow>

Available at: http://shop.kernelconcepts.de

This reader unfortunatelly only supports a so called "fixed pinlength" which is from 6? - 8 digits.
The number of digits has to be transferred beforehand to the reader. This is done by
writing a special string into the "Login Data" field of the card.
The strings to be written are prepared in the two files login-data_6_8.txt and login-data_8_8.txt
in this directory. (First Number: Number of digits for the user Password, second Number: digits for the Admin)

The strings can be written to the card in the following way:
```
>gpg --card-edit
>admin
>login <login-data_8_8.txt
>quit
```

Afterwards the gpg2 --card-status command should provide you with something like this:
```
Application ID …: D276000124010200000XYZ
Version ……….: 2.0
Manufacturer …..: ZeitControl
Serial number ….: 0000XXXX
Name of cardholder: John Smith
Language prefs …: de
Sex …………..: männlich
URL of public key : [nicht gesetzt]
Login data …….: gpguser\n\x14P=6,8\n      <-- this is important
Signature PIN ….: nicht zwingend
Key attributes …: 2048R 2048R 2048R
Max. PIN lengths .: 32 32 32
PIN retry counter : 3 0 3
Signature counter : 5
Signature key ….: XXXX FD48 XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
created ….: 2014-02-06 22:38:04
Encryption key….: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
created ….: 2014-02-06 22:38:04
Authentication key: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
created ….: 2014-02-06 22:38:04
General key info..: [none]
```

Beside this a recent gpg version and a recent ccid library is necessary.
The following Version did work for me:
- ccid-1.4.15
- gnupg-2.0.22

They are used by the installer.