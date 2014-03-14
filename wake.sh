#!/bin/bash

# Включение всех PC
DIRECTORY=$(pwd)
#DIRECTORY="/home/$USER/remote-control"
machost=($(cat $DIRECTORY/remotecontrol.conf | awk '{print $2}'))

#Перебираем MAC-adress-а и посылаем magic package                    
for ((i=0; i<=${#machost[*]}; i++)); do 
#echo ${machost[$i]}
/usr/bin/wakeonlan ${machost[$i]} 
done
