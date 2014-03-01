#!/bin/bash

./lockdown_system.sh
./prep_crypto_system.sh
./personalize_system.sh
./install_r-pi_hw_random.sh
../gpg_scripts/install.sh
./install_gpg2_from_source.sh

