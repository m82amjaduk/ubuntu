#!/bin/bash 
# Run $ chmod +x dropbox.sh
# $ ./dropbox.sh

#gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
#gsettings set org.gnome.settings-daemon.plugins.power active false
#http://askubuntu.com/questions/67355/how-do-i-completely-turn-off-screensaver-and-power-management
#sudo apt-get install p7zip-full
#http://askubuntu.com/questions/348173/how-to-install-7zip-through-terminal-to-extract-rar-files


NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
NOW=$(date +'%Y-%m-%d')
LOG_FILE="/tmp/dropbox_install_$NOW"   
MACHINE=$(uname -m) 


red() {
    echo -e -n "$RED$*$NORMAL"
}
green() {
    echo -e -n "$GREEN$*$NORMAL"
}
yellow() {
    echo -e -n "$YELLOW$*$NORMAL"
}
 
 


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
		#red "Please comment line content exit \n";  exit; 
		#ensure you have all the latest updates in your PPAs
		green "\n\n\nUpdating all PPAs: \n"
		red "$ sudo apt-get update \n\n\n ";
		sudo apt-get update > $LOG_FILE 

		green "Downloading........... \n"
		cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.$MACHINE" | tar xzf -
		green "Installing........... Please wait !!! [5/10 Min]\n"
		sudo apt-get install nautilus-dropbox >> $LOG_FILE 
		
		green "Installation Succeeded \n"
		green "Please restart after 10 min. \n" 
                red "Running Dropbox service :: $ ~/.dropbox-dist/dropboxd"
                mkdir -m 755 ~/Dropbox 
                touch ~/Dropbox/.htaccess
                chmod 755 ~/Dropbox/.htaccess
		~/.dropbox-dist/dropboxd 
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


#*** Mound Image file to USB, Ubuntu OS.
# df -h # to find USB Location
# sudo dd if=ISO_LOCATION of=USB_LOCATION.
# sudo dd if=/home/amzad/Downloads/ubuntu-14.04.1-desktop-i386.iso of=/dev/sdb

