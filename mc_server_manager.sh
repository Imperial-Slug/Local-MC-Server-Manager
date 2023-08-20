#!/bin/bash
# Bash Minecraft Server Manager
# By Sam Petch

set -euo pipefail

   main_menu() {
	echo -ne "
	
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
	
	
	main_menu
	
# Wait for user input before exiting
read -n 1 -s -r -p "Press any key to exit..."
	
