#!/bin/bash

# Включение PC по имени
DIRECTORY=$(pwd)
#DIRECTORY="/home/$USER/remote-control"
host=($(cat $DIRECTORY/remotecontrol.conf | grep "$1" | awk '{print $2}'))

/usr/bin/wakeonlan $host 
