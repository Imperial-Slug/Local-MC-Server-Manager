#!/bin/bash
# Bash Minecraft Server Manager
# By Sam Petch

# ======================================= DEFINITIONS ==================================================

DATA_FILE=./conf/data
is_server=0
set -euo pipefail
RED='\033[0;31m'
RESET='\033[0m'
BOLD='\033[1m'

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



check_for_config() {

if [ -f "$DATA_FILE" ]; then
    source $DATA_FILE
    
else create_data_file
fi
}

 receive_menu_option() {
	
     read -n 1 -s -p "Type the desired option's corresponding number." chosen_option
	execute_menu_option

	}
	
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

get_space_length() {
# Get the difference in length between the menu item and the current 
# terminal window, and divide it by 2 so the function can print 
# the appropriate amount of spaces to centre the item.
# Define MENU_LENGTH at runtime during use of the function.
columns=$(tput cols)
space_length=$(( (columns - MENU_LENGTH) / 2 ))


}

create_data_file() {

    	mkdir -p ./conf
    	touch ./conf/data
    	now=$(date)
    	printf "# Configuration file created on $now\n  no_servers_stored=1\n server_array=()" > $DATA_FILE
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

set_nst_zero() {

search="no_servers_stored=1"
replace="no_servers_stored=0"

# Check if the file exists
if [ -e "$DATA_FILE" ]; then
    if grep -qF "$search" "$DATA_FILE"; then
        sed -i "s/$search/$replace/g" "$DATA_FILE"
    else
    echo -e "\n\n${RED}${BOLD}Error: Couldn't find the no_servers_stored variable in the data file.  This may be a bug.${RESET}  "
    read -s n 1
    fi
else
    echo -e "\n\n${RED}${BOLD}Error: Couldn't find the data file.  This may be a bug.${RESET}  "
read -s n 1
fi
source $DATA_FILE
}


#=========================

check_if_server_stored() {

# Check if the file exists
if [ -e "$DATA_FILE" ]; then
    if grep -qF "server_array+=(\"${server_path}\")" "$DATA_FILE"; then
        server_is_stored=1
    else
    server_is_stored=0
    fi
else
    echo -e "\n\n${RED}${BOLD}Error: Couldn't find the data file.  This may be a bug.${RESET}  "
read -s n 1
fi
source $DATA_FILE
}

#=====================


op5_add_new_server_path() {
get_space_length 
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
  read server_path
 check_if_mc_server
 
 if [[ $is_server -eq 1 ]]; then
 check_if_server_stored
 if [[ $server_is_stored -eq 0 ]]; then add_server
 else echo -e "\n\n${RED}${BOLD}Cannot add server. Already stored.${RESET}"
 read -s -n 1
 fi
 else echo -e "\n\n${RED}${BOLD}Cannot add path: not a server.${RESET}"
read -s -n 1 
option_5
 fi
 
 display_main_menu

}


check_if_mc_server() {
if [ -d "$(eval echo $server_path)" ]; then
    # Check for required files and folders
    if [ -f "$(eval echo $server_path/server.jar)" ]; then
        if [ -f "$(eval echo $server_path/eula.txt)" ]; then
            if [ -d "$(eval echo $server_path/logs)" ]; then
            	is_server=1
            else
                is_server=0
            fi
        else
            is_server=0
        fi
    else
    	is_server=0
    fi
else
	is_server=0
fi

}

 
add_server() {

server_array+=("$server_path")
 printf "\n server_array+=(\"${server_path}\")" >> $DATA_FILE
  source $DATA_FILE
  printf "\n
  Here are your currently stored servers:
  
  "
  
  echo ${server_array[@]}
  printf "\n\n"
  
  read -p "OKAY, SERVER ADDED"
  source $DATA_FILE
  if [ $no_servers_stored == "1" ];  then 
set_nst_zero
  source $DATA_FILE
fi

}


# Option_5 execution
option_5() {

MENU_LENGTH=39
clear
get_space_length
op5_add_new_server_path

}


execute_menu_option() {
 
 case ${chosen_option} in

  1)
    printf "1"
    ;;

  2)
    option_2
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
  
esac
 display_main_menu
 
 }


check_for_stored_servers() {
	source $DATA_FILE
# If the last command exited with status of 0...
	if [[ $? -eq 0 ]]
	then printf '%b\n' "\nConfiguration check complete.  Ready to go.\n"
	MENU_LENGTH=32
	get_space_length
	create_line_to_size
	if [[ $no_servers_stored -eq 1 ]]
	then
	
	echo -e "${RED}${BOLD}It looks like you don't have any Minecraft servers configured.${RESET}\n" 
	create_line_to_size
	read -s -n 1
	
	
	read -n 1 -s -r -p "
To add a server to Bash MC Server Manager, exit this dialogue with any key.  
Then, you can either press 2 to install a new Minecraft server 
and add it to this program or press 5 to add an existing Minecraft server.

"
create_line_to_size
	fi
	
	else echo -e "${RED}${BOLD}Error checking for configuration file!${RESET}\n "
	read -p -n 1 -s "Press any button to exit.
	"
	fi
	
display_main_menu

}

option_2() {
  clear
  printf "\n"
  MENU_LENGTH=19
  get_space_length
  create_line_to_size
  read -s -n 1 -p "Install a new Minecraft server? (y/n) " ans
  printf "\n\n"
  
  if [[ "$ans" != [nN] ]]; then
    create_line_to_size
    read -p "Enter the filepath you want to install your Minecraft server to: 
    
Server path:  " server_path
    check_if_mc_server
    check_if_server_stored
    
    echo $is_server
    echo $server_is_stored
    
    if [ -d "$server_path" ]; then
      printf "\nIs directory"
      
      if [[ $is_server == "0" ]]; then
        if [[ $server_is_stored == "1" ]]; then
          read -p "Can't make a new server here: a server is already stored at the specified filepath."
          display_main_menu
        else
	    create_new_server
        fi
      fi
    else
      echo "\n${RED}${BOLD}This directory doesn't exist yet. Create it and download server.jar? (y/n) ${RESET}\n"
      read ans
      
      if [[ "$ans" == [nN] ]]; then
        echo -e "${RED}${BOLD}Resetting...${RESET}"
        option_2
      else
        server_path_expanded="${server_path/#\~/$HOME}"
        mkdir -p "$server_path_expanded"
        create_new_server
      fi
    fi
  else
    echo -e "${RED}${BOLD}Aborting server creation. Press any key to return to the main menu.${RESET}" 
  read -s -n 1
  display_main_menu
  fi
}


create_new_server() {

clear

wget https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar
echo "\n${RED}${BOLD}Download completed! Run server.jar?${RESET}\n"

read run_jar

if [ $run_jar != [nN] ]; then run_server
fi

}


run_server() {
echo "\n${RED}${BOLD}Starting Minecraft server...${RESET}\n"
read -n 1
}

   display_main_menu() {
   
        clear && printf %b "$main_menu"
	
	receive_menu_option
	
	}
	
    
	
# ======================================= MAIN CALL STACK ==================================================
	
	check_for_config 
	check_for_stored_servers
	

