#!/bin/bash 
# Run $ chmod +x dropbox.sh


NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
NOW=$(date +'%Y-%m-%d')
LOG_FILE="/tmp/dropbox_install_$NOW" 
DIR_SCRIPT="/home/amzad/Dropbox/Scripts/Ubuntu"

red() {
    echo -e -n "$RED$*$NORMAL"
}
green() {
    echo -e -n "$GREEN$*$NORMAL"
}
yellow() {
    echo -e -n "$YELLOW$*$NORMAL"
}
 
 
#ensure you have all the latest updates in your PPAs
green "\n\n\nUpdating all PPAs: \n"
red "$ sudo apt-get update \n\n\n ";
sudo apt-get update > $LOG_FILE 

#############################################################


dropbox_install() {
	#install Dropbox.
	yellow "(If promted for password, please enter the password for the user:" 
	whoami 
	yellow " )\n"

	if [ -f ~/.dropbox-dist/dropboxd ]
	then
		green "Dropbox is already installed on " 
		hostname 
		green "Run "
		red "# ~/.dropbox-dist/dropboxd " 
		green " to start Dropbox deamon.\n"
	else
		red "Please comment line content exit \n";  exit; 
		green "Downloading........... \n"
		cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
		green "Installing........... Please wait !!! \n"
		sudo apt-get install nautilus-dropbox >> $LOG_FILE 
		green "Installation Succeeded \nRun "
		red "# ~/.dropbox-dist/dropboxd " 
		green " to start Dropbox deamon.\n"
	fi
}

while true; do
	read -p "Would you like to install Dropbox? " yn
	case $yn in
		[Yy]* ) dropbox_install; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done 
chmod 400 dropbox.sh
