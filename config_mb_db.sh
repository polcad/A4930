#!/bin/sh
# cd <install-path>/share/uhd/utils
# to override the clock rate specified in the EEPROM
#uhd_usrp_probe --args="mcr=52e6"
./usrp_burn_mb_eeprom --args="type=usrp1" --key=mcr --val=52000000
./usrp_burn_mb_eeprom --args="type=usrp1" --key=serial --val=201304A0
./usrp_burn_mb_eeprom --args="type=usrp1" --key=name --val=Koala_MB_2013
./usrp_burn_db_eeprom --ser=20130400A
# GSX900
./burn-db-eeprom -t rfx900 -A -f
./usrp_burn_db_eeprom --id=0x0025 --unit=RX --slot=A
./usrp_burn_db_eeprom --id=0x0029 --unit=TX --slot=A
# GSX1800
# ./burn-db-eeprom -t rfx1800 -A -f
#./usrp_burn_db_eeprom --id=0x0034 --unit=RX --slot=A
#./usrp_burn_db_eeprom --id=0x0035 --unit=TX --slot=A
uhd_usrp_probe
