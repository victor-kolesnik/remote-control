#!/bin/bash

# Обновление всех PC
DIRECTORY=$(pwd)
#DIRECTORY="/home/$USER/remote-control"
host=($(cat $DIRECTORY/remotecontrol.conf | awk '{print $3}'))

for ((i=0; i<=${#host[*]}; i++)); do 
#echo ${host[$i]}
ssh root@${host[$i]} "apt-get update -y; apt-get upgrade -y;" 
done
