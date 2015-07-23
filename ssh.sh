#!/bin/bash
 
 
# Sample Run ::  ~/Dropbox/Scripts/tools/toolsScripts/ssh.sh amzad@192.168.1.46
 
 
# This Script will help setup SSH connection to a remote host without reentering password. 
 
 
SCRIPT_DIR=$(pwd);
NORMAL=$(tput sgr0);
GREEN=$(tput setaf 2; tput bold); 
green() { echo -e -n "$GREEN$*$NORMAL"; }
 
 
REMOTE_HOST=$1;  # amzad@192.168.1.26 
    
green "$REMOTE_HOST \n $SCRIPT_DIR \n\n";
 
 
green "Do you have password for $REMOTE_HOST ? \n\n"; 
read -sn 1 -p 'Press CTRL+C to exit. And press any key to continue... ';echo
 
 
green "Press ENTER, ENTER, ENTER \nDo not enter 'passphrase'\n"; 
cd ~
ssh-keygen; 
pwd;
cd $SCRIPT_DIR;
 
 
green "Enter 'yes' and password if asked. \n";
green "ssh-copy-id -i ~/.ssh/id_rsa.pub $REMOTE_HOST \n"; 
ssh-copy-id -i ~/.ssh/id_rsa.pub $REMOTE_HOST; 
green "ssh-add\n";
ssh-add;
green "ssh $REMOTE_HOST";  
green "\n\n\nConnecting to remote host .... \n\n";
ssh $REMOTE_HOST 
