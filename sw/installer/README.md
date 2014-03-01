content/usage
=====

__install_gpg2_from_source.sh:__
This installes a gpg2 directly from the sources and adds support for a Gemalto Pinpad reader 
which can be used with a open-pgp-smartcard (https://www.google.de/search?q=open+pgp+smartcard)
```
wget https://raw.github.com/bbprojects2013/crypi/master/sw/installer/install_gpg2_from_source.sh
chmod 755 install_gpg2_from_source.sh
./install_gpg2_from_source.sh
```

__install_r-pi_hw_random.sh:__
This script installes the necessary components for using the HW random generator in the 
raspberry pi SOC

__lockdown_system.sh:__
This script secures the system against network intruders - run this first

__prep_crypto_system.sh:__
Prepare the system for crypto work (config RAM Disk e.c.)


__personalize_system.sh:__
Just some personalisation of the system to my (German) needs :-)