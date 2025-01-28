#!/bin/bash

printf "Fetching data, please wait...\n\n"
 
CHUP=$(checkupdates | grep 'discord\|steam')
if [[ $CHUP = "" ]]; then
    echo "No updates for Discord nor Steam"
    exit
else
	echo "Updates for fun days found:"
	echo $CHUP
fi
