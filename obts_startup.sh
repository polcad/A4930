#!/bin/bash
#Version 0.20
#Written by Amil Khanzada (http://AmilKhanzada.com/)
#This script is released as is. Use at your own risk.
#Released to public domain
#See https://wush.net/trac/rangepublic/wiki/StartupScripts

echo Runs OpenBTS, FreeSWITCH, smqueue, sipauthserve, and finally OpenBTSCLI
echo Make sure that the OBTS_ROOT and FS_ROOT variables in this script are set correctly and that your radio is attached via USB!

#get sudo privileges
sudo echo 

#store FreeSWITCH and OpenBTS root locations
OBTS_ROOT="/home/przemek/Downloads/OpenBTS/public/"
FS_ROOT="/usr/local/freeswitch"

#start FreeSWITCH
cd $FS_ROOT/bin
sudo killall freeswitch &> /tmp/tmp
ulimit -s 240
sleep 2s
sudo gnome-terminal -x sh -c "sudo ./freeswitch" &


#start smqueue and sipauthserve
cd $OBTS_ROOT
sudo gnome-terminal --tab -e "sudo subscriberRegistry/trunk/sipauthserve" --tab -e "sudo smqueue/trunk/smqueue/smqueue" &

#start OpenBTS
cd $OBTS_ROOT/openbts/trunk/apps
sudo killall transceiver &> /tmp/tmp #sometimes necessary
sudo gnome-terminal -x sh -c "sudo ./OpenBTS" &


#finally, start the CLI
echo ---All other processes initialized. Please wait a few seconds for FreeSWITCH to initialize---
echo
sudo ./OpenBTSCLI

