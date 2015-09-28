#!/bin/bash
#Version 0.20
#Written by Amil Khanzada (http://AmilKhanzada.com/)
#This script is released as is. Use at your own risk.
#Released to public domain
#See https://wush.net/trac/rangepublic/wiki/StartupScripts

echo Runs OpenBSC, OpenBTS, LCR, OpenBTS transceiver, and finally OpenBTSCLI
echo Make sure that the OBTS_ROOT and FS_ROOT variables in this script are set correctly and that your radio is attached via USB!

#get sudo privileges
sudo echo 

#store FreeSWITCH and OpenBTS root locations
OBTS_ROOT="/home/przemek/openbts"
FS_ROOT="/usr/local/freeswitch"

#start OsmoBSC
sudo gnome-terminal -x sh -c "osmo-nitb -c ~/.osmocom/open-bsc.cfg -l ~/.osmocom/hlr.sqlite3 -P -m -C --debug=DRLL:DCC:DMM:DRR:DRSL:DNM" &
#start OsmoBTS
sudo gnome-terminal -x sh -c "osmobts-trx -c ~/.osmocom/osmo-bts.cfg" &
#start LCR
sudo gnome-terminal -x sh -c "lcr start" &

#start OpenBTS transceiver
cd $OBTS_ROOT/apps
sudo killall transceiver &> /tmp/tmp #sometimes necessary
sudo gnome-terminal -x sh -c "sudo ./transceiver" &

#finally, start the CLI
echo ---All other processes initialized. Please wait a few seconds for FreeSWITCH to initialize---
echo
sudo ./OpenBTSCLI
