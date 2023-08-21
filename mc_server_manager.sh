#!/bin/bash
# Bash Minecraft Server Manager
# By Sam Petch

# ======================================= DEFINITIONS ==================================================

DATA_FILE=./conf/data
now=$(date)
set -euo pipefail

# If the datafile exists already in the script's conf directory, then proceed with normal startup.
check_for_config() {

if [ -f "$DATA_FILE" ]; then
    printf "$DATA_FILE exists.\n"
    source $DATA_FILE
    
    
else printf "The datafile doesn't exist.  Creating the datafile in ./conf... \n"
    	mkdir -p ./conf
    	touch ./conf/data
    	printf "# Configuration file created on $now" > ./conf/data
fi
}

   display_main_menu() {
  
  check_for_config
  
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
	
	"
	}
	
# ======================================= EXECUTION ==================================================
	
	display_main_menu
	
# Wait for user input before exiting
read -n 1 -s -r -p "Press any key to exit..."
	
