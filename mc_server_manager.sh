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





create_line_to_size() {

columns=$(tput cols)

c=1              
while [[ $c -le $columns ]]; do
    printf "="
    ((c=c+1)) 
done
printf "
"
c=1
}

help_to_centre() {
# Get the difference in length between the menu item and the current 
# terminal window, and divide it by 2 so the function can print 
# the appropriate amount of spaces to centre the item.

space_length=$(( (COLUMNS - MENU_LENGTH) / 2 ))


}

create_data_file() {

printf "The datafile didn't exist.\n"
    	mkdir -p ./conf
    	touch ./conf/data
    	now=$(date)
    	printf "# Configuration file created on $now\n  no_servers_stored=1\n server_array=()" > ./conf/data
	printf "Created conf directory with data file."
	source $DATA_FILE

}


print_space_to_centre() {

i=0              
while [[ $i -le $space_length ]]; do
    printf " "
    ((i=i+1)) 
done
i=0
}


option_5_menu() {
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

printf "Please specify the filepath of the local\n Minecraft server you would like to add.\nExample: ~/mc_servers/my_server_directory\n"
printf "\n"
   create_line_to_size
   printf "New Server File Path:  "
   # Saves the cursor's position, moves the cursor down by 1 line, and restores the cursor's position
   # so that the user input can stay in between the lines but the second line can generate before the
   # termination of the "read" prompt.
  tput sc 
  tput cud1 
  create_line_to_size
  tput rc 
  read -e -p "" server_path
 
 server_array+=("$server_path")
 printf "\n server_array+=(\"${server_path}\")" >> ./conf/data
  source $DATA_FILE
  
  echo ${server_array[@]}
  printf "\n\n\n\n"
  
  read -p "Okay"
  printf "Downloading server.jar via Rust http request.  Please wait..."
  
  ./jar_grabber/target/release/jar_grabber
  
   
}

# Option_5 execution
option_5() {

MENU_LENGTH=39
clear
help_to_centre
option_5_menu

}



execute_menu_option() {
 
 case ${chosen_option} in

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

read -s -n 1 -p "Okay, option chosen."
 
 }


check_for_stored_servers() {

# If the last command exited with status of 0...
	if [[ $? -eq 0 ]]
	then printf '%b\n' "\nConfiguration check complete.  Ready to go.\n"
	create_line_to_size
	if [[ $no_servers_stored -eq 1 ]]
	then printf "It looks like you don't have any Minecraft servers configured.\n" 
	create_line_to_size
	
	read -n 1 -s -r -p "
To add a server to Bash MC Server Manager, exit this dialogue with any key.  
Then, you can either press 2 to install a new Minecraft server 
and add it to this program or press 5 to add an existing Minecraft server.

"
create_line_to_size

	fi
	
	display_main_menu
	
	else printf " Error checking for configuration file!\n "
	read -p -n 1 -s "Press any button to exit.
	"
	fi
	
}


check_for_config() {

if [ -f "$DATA_FILE" ]; then
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
	
    
	
# ======================================= MAIN CALL STACK ==================================================
	
	check_for_config 
	check_for_stored_servers
	

