#!/bin/bash
#Version P28.1
#This script is released as is. Use at your own risk.
#Released to public domain

echo "Runs Asterisk, smqueue, sipauthserve, OpenBTS and finally OpenBTSCLI"
echo "Make sure that your radio is attached via USB"

#get sudo privileges
sudo echo 

#store OpenBTS root locations
OBTS_ROOT="/home/przemek/openbts/public"

#start asterisk
sudo asterisk

#start smqueue and sipauthserve
cd $OBTS_ROOT
sudo xterm -n "Smqueue" -e "sudo smqueue/trunk/smqueue/smqueue"  &
sudo xterm -n "sipauthserve" -e "sudo subscriberRegistry/trunk/sipauthserve"  &

#start OpenBTS
cd $OBTS_ROOT/openbts/trunk/apps
sudo killall transceiver &> /tmp/tmp #sometimes necessary
sudo xterm -n "OpenBTS" -e "sudo ./OpenBTS" &
#-x sh -c "sudo ./OpenBTS" &

#finally, start the CLI
sudo xterm -n "OpenBTS" -e "sudo ./OpenBTSCLI" &
echo "---All other processes initialized. Please wait a few seconds for radio to initialize---"

