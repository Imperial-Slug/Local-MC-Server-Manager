#!/bin/bash
# Bash Minecraft Server Manager
# By Sam Petch

# ======================================= DEFINITIONS ==================================================

DATA_FILE=./conf/data
set -euo pipefail
main_menu="
	
	     ============================================
            |  BASH MINECRAFT SERVER MANAGER: MAIN MENU  |
	     ============================================
	
	Welcome to the bash terminal Minecraft server manager.
	Enter one of the options listed below.
	
	1) Launch a Minecraft server.
	
	2) Install a new Minecraft server.
	
	3) Check my Minecraft servers for updates.
	
	4) Configure automatic server updates.
	
	5) Add an existing local Minecraft Server to BASH MINECRAFT MANAGER.
	
	6) Minecraft Server Administration
	
	\n\n"


no_servers_message=" 
It looks like you don't have any Minecraft servers configured.  To add a server to Bash MC Server Manager, exit this dialogue with any key; \n then you can either press 2 to install a new Minecraft server and add it to this program, or press 5 to add an existing Minecraft server.
 "

create_line_to_size() {

c=1              
while [[ $c -le $COLUMNS ]]; do
    printf "="
    ((c=c+1)) 
done

}

help_to_centre() {
# Get the difference in length between the menu item and the current 
# terminal window, and divide it by 2 so the function can print 
# the appropriate amount of spaces to centre the item.

space_length=$(( (COLUMNS - MENU_LENGTH) / 2 ))


}

create_data_file() {

printf "The datafile didn't exist.  Created the datafile in ./conf. \n"
    	mkdir -p ./conf
    	touch ./conf/data
    	now=$(date)
    	printf "# Configuration file created on $now\n  no_servers_stored=1" > ./conf/data
	printf "Created conf directory with data file."
	source $DATA_FILE

}


print_space_to_centre() {

i=0              
while [[ $i -le $space_length ]]; do
    printf " "
    ((i=i+1)) 
done

}


option_5() {
 
clear 
MENU_LENGTH=39
help_to_centre

print_space_to_centre
printf "=======================================
"

print_space_to_centre

printf "| ADD EXISTING LOCAL MINECRAFT SERVER |
"

print_space_to_centre

printf "=======================================
"


printf "
Please specify the filepath of the local 
Minecraft server you would like to add: 
"
   
   create_line_to_size

 read -p "
 New Server File Path:  "

}



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
    option_5
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
    
else create_data_file
fi
}

 receive_menu_option() {
	
     read -n 1 -s -p "Type the desired option's corresponding number." chosen_option
     echo ""
     echo -e -n "\n$chosen_option chosen.\n"

	execute_menu_option

	
	}
	
	

   display_main_menu() {
   
        clear && printf %b "$main_menu"
	
	receive_menu_option
	
	}
	
    
	
# ======================================= EXECUTION ==================================================
	
	check_for_config 
	
	# If the last command passed exited with status of 0...
	
	if [[ $? -eq 0 ]]
	then printf '%b\n' " Configuration check complete.  Ready to go."
	
	if [[ $no_servers_stored -eq 1 ]]
	then read -n 1 -s -p "$no_servers_message"
	fi
	
	display_main_menu
	
	else printf " Error checking for configuration file!\n "
	read -p -n 1 -s "Press any button to exit.\n "
	fi

