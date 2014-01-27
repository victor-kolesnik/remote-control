#!/bin/bash

DIRECTORY="/home/victor/rc"
host=($(cat $DIRECTORY/remotecontrol.conf | grep "$1" | awk '{print $2}'))

/usr/bin/wakeonlan $host 
