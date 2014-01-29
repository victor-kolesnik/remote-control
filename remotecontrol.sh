#!/bin/sh


#Главная форма
start_dialog() {
DIALOG=${DIALOG=dialog}
DIALOG2=${DIALOG2=dialog}
TMPFCMD="/tmp/cmd.tmp"
DIRECTORY="/home/$USER/remotecontrol"
$DIALOG --clear --title "RemoteControle" \
        --menu 'Choose command to execute' 20 51 10 \
	"1) Update all" " "\
	"2) Install package on All PCs" " "\
	"3) ..." " "\
	"Please enter command" " "\
	"Enable all PC" " "\
	"Enable PC by number" " "\
	"Show avaliable PC" " "\
	"Shutdown All PCs" " " 2> $TMPFCMD
CMD2RUN=$(cat $TMPFCMD)

	case "$CMD2RUN" in
		"1) Update all")
		#command
		$DIRECTORY/update.sh; start_dialog
	
	#list_of_PC_dialog
		;;
		"2) Install package on All PCs")
		#command
		install_package

	#list_of_PC_dialog
		;;
		"3) ...")
		#command
	list_of_PC_dialog
		;;
		"Please enter command")
		#command
		enter_command
		;;
	"Enable all PC")
		#command
		$DIRECTORY/wake.sh; start_dialog
		;;
	"Enable PC by number")
		#command
		enter_number
		;;
	"Show avaliable PC")
	list_of__enable_PC_dialog
		#command
		;;
	"Shutdown All PCs")
		#command
		$DIRECTORY/shutdownall.sh; start_dialog
		;;
	esac

}

s="ddd"
#Форма статуса выполнения команды 
#В качестве второго аргумента можно передавать статус выполнения команды
list_of_PC_dialog() {
	$DIALOG  --ok-label LOG  --cancel-label SCREEN --radiolist "Press ESC to back" 25 51 17 \
	"PC11" "$s" off\
	"PC12" "" off\
	"PC13" "" off\
	"PC14" "" off\
	"PC21" "" off\
	"PC22" "" off\
	"PC23" "" off\
	"PC24" "" off\
	"PC31" "" off\
	"PC32" "" off\
	"PC33" "" off\
	"PC34" "" off\
	"PC41" "" off\
	"PC42" "" off\
	"PC43" "" off\
	"PC44" "" off 2> $TMPFCMD
case $? in
  	0)
  	 #log_file
cat $TMPFCMD
;;
  	1)
   	 #screen
cat $TMPFCMD
;;
	255)
   	 start_dialog;;

  	
	esac
}

#Список компьютеров
#В качестве второго аргумента можно передавать статус 

list_of__enable_PC_dialog() {

	pc11=$(nmap -sP 192.168.73.11 | grep 'Host is up')
	pc12=$(nmap -sP 192.168.73.12 | grep 'Host is up')
	pc13=$(nmap -sP 192.168.73.13 | grep 'Host is up')
	pc14=$(nmap -sP 192.168.73.14 | grep 'Host is up')
	pc21=$(nmap -sP 192.168.73.21 | grep 'Host is up')
	pc22=$(nmap -sP 192.168.73.22 | grep 'Host is up')
	pc23=$(nmap -sP 192.168.73.23 | grep 'Host is up')
	pc24=$(nmap -sP 192.168.73.24 | grep 'Host is up')
	pc31=$(nmap -sP 192.168.73.31 | grep 'Host is up')
	pc32=$(nmap -sP 192.168.73.32 | grep 'Host is up')
	pc33=$(nmap -sP 192.168.73.33 | grep 'Host is up')
	pc34=$(nmap -sP 192.168.73.34 | grep 'Host is up')
	pc41=$(nmap -sP 192.168.73.41 | grep 'Host is up')
	pc42=$(nmap -sP 192.168.73.42 | grep 'Host is up')
	pc43=$(nmap -sP 192.168.73.43 | grep 'Host is up')
	pc44=$(nmap -sP 192.168.73.44 | grep 'Host is up')
	$DIALOG  --ok-label Enable  --cancel-label Back --radiolist "dfsdsd" 51 90 17 \
	"pc11 00:1f:c6:b6:29:ae 192.168.73.11" "$pc11" off\
	"pc12 00:1f:c6:b6:29:88 192.168.73.12" "$pc12" off\
	"pc13 00:1f:c6:b6:29:ce 192.168.73.13" "$pc13" off\
	"pc14 00:1f:c6:b6:28:1d 192.168.73.14" "$pc14" off\
	"pc21 00:1f:c6:b6:23:c2 192.168.73.21" "$pc21" off\
	"pc22 00:1f:c6:b6:2a:91 192.168.73.22" "$pc22" off\
	"pc23 00:1f:c6:b6:29:64 192.168.73.23" "$pc23" off\
	"pc24 00:1f:c6:b6:29:c6 192.168.73.24" "$pc24" off\
	"pc31 00:1f:c6:b6:2a:79 192.168.73.31" "$pc31" off\
	"pc32 00:1f:c6:86:e0:f8 192.168.73.32" "$pc32" off\
	"pc33 00:1f:c6:86:e1:95 192.168.73.33" "$pc33" off\
	"pc34 00:1f:c6:86:e1:00 192.168.73.34" "$pc34" off\
	"pc41 00:1f:c6:b6:2a:a7 192.168.73.41" "$pc41" off\
	"pc42 00:1f:c6:86:e0:fe 192.168.73.42" "$pc42" off\
	"pc43 00:13:74:00:5c:38 192.168.73.43" "$pc43" off\
	"pc44 00:1f:c6:b6:29:ca 192.168.73.44" "$pc44" off 2> $TMPFCMD 

case $? in
  	0)
  	 #enable

;;
  	1)
   	 #back
	start_dialog

;;
  	
	esac
}


#Ввод пользовательской команды
enter_command() {
$DIALOG --title "Enter command" --clear \
        --inputbox "Enter command" 16 51 2> $TMPFCMD

case $? in
  0)
#Выполнение команды
send_command=$(cat $TMPFCMD)
#echo $send_command
$DIRECTORY/send_command.sh $command; start_dialog
   ;;
  1)
#Отмена ввода и возращение в главное меню
   start_dialog;;	
esac
}

#Установка пакета
install_package() {
$DIALOG --title "Enter package" --clear \
        --inputbox "Enter package" 16 51 2> $TMPFCMD

case $? in
  0)
#Установка пакета
package=$(cat $TMPFCMD)
#echo $package
$DIRECTORY/install_package.sh $package; start_dialog
   ;;
  1)
#Отмена ввода и возращение в главное меню
   start_dialog;;	
esac
}

enter_number() {
$DIALOG --title "Enter command" --clear \
        --inputbox "Enter command" 16 51 2> $TMPFCMD

case $? in
  0)

#Выполнение команды
number_pc=$(cat $TMPFCMD)
#echo $number_pc
$DIRECTORY/enable.sh $number_pc; start_dialog
   ;;
  1)
#Отмена ввода и возращение в главное меню
   start_dialog;;	
esac
}



start_dialog

rm -f $TMPFCMD