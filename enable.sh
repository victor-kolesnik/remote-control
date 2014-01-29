#!/bin/bash

# Включение PC по имени

DIRECTORY="/home/$USER/remotecontrol"
host=($(cat $DIRECTORY/remotecontrol.conf | grep "$1" | awk '{print $2}'))

/usr/bin/wakeonlan $host 
