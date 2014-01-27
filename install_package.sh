#!/bin/bash

DIRECTORY="/home/victor/rc"
host=($(cat $DIRECTORY/remotecontrol.conf | awk '{print $3}'))

for ((i=0; i<=${#host[*]}; i++)); do 
#echo ${host[$i]}
#echo $1
ssh root@${host[$i]} "apt-get update -y; apt-get install $1 -y" 
done
