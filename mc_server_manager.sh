#!/bin/bash
# Bash Minecraft Server Manager
# By Sam Petch

# ======================================= DEFINITIONS ==================================================

DATA_FILE=./conf/data
set -euo pipefail

# If the datafile exists already in the script's conf directory, then proceed with normal startup.

execute_menu_option() {
 
 case $chosen_option in

  1)
    printf "1"
    ;;

  2)
    echo -n "2"
    ;;

  3)
    echo -n "3"
    ;;

  4)
    echo -n "4"
    ;;

  5)
    echo -n "5"
    ;;
  
  6)
    echo -n "6"
    ;;
  
  *)
    echo -n "unknown"
    ;;
esac

read -p "Okay, option chosen\n."
 
 }

check_for_config() {

if [ -f "$DATA_FILE" ]; then
    printf "$DATA_FILE exists.\n"
    source $DATA_FILE
    
    
else printf "The datafile doesn't exist.  Creating the datafile in ./conf... \n"
    	mkdir -p ./conf
    	touch ./conf/data
    	now=$(date)
    	printf "# Configuration file created on $now" > ./conf/data
fi
}

 receive_menu_option() {
	
     read -n 1 -s -p "Type the desired option's corresponding number." chosen_option
     echo ""
     echo -e "\n$chosen_option chosen.\n"

	execute_menu_option

	
	}
	
	

   display_main_menu() {
  
	printf "
	
	     ============================================
            |  BASH MINECRAFT SERVER MANAGER: MAIN MENU  |
	     ============================================
	
	Welcome to the bash terminal Minecraft server manager.
	Enter one of the options listed below.
	
	1) Launch a Minecraft server.
	
	2) Install a new Minecraft server.
	
	3) Check my Minecraft servers for updates.
	
	4) Configure automatic server updates.
	
	5) Add an existing Minecraft Server to BASH MINECRAFT MANAGER.
	
	6) Minecraft Server Administration
	
	\n\n"
	
	receive_menu_option
	
	}
	
    
	
# ======================================= EXECUTION ==================================================

	check_for_config 
	
	# If the last command passed exited with status of 0...
	
	if [[ $? -eq 0 ]]
	then printf " Configuration check complete.  Ready to go."
	display_main_menu
	else printf " Error checking for configuration file!\n "
	read -p -n 1 -s "Press any button to exit.\n "
	fi

