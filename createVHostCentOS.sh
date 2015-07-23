#!/bin/bash

## Lines with '##' can be run from CLI to achive same thing.
## sudo -s  ## Chnage to ROOT. 
## whoami  ## to find current user
## chmod +x createVHost.sh  ## Change permission to executable.    
## chmod 777 /home/amzad/Dropbox/Scripts/tools/toolsScripts/createVHost.sh
## chmod 400 /home/amzad/Dropbox/Scripts/tools/toolsScripts/createVHost.sh
## /home/amzad/Dropbox/Scripts/tools/toolsScripts/createVHost.sh s c rw.lc /home/amzad/dev/rw amzad
## /home/amzad/Dropbox/Scripts/tools/toolsScripts/createVHost.sh Q C


DIR_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
FILE_SCRIPT=$(basename $0);
NOW=$(date +'%Y-%m-%d-%T');
NORMAL=$(tput sgr0);rw.lc
GREEN=$(tput setaf 1; tput bold; ); 
msge() { echo -e -n "$GREEN$*$NORMAL"; }




INSTALL_MODE=$1
CONFIRM=$2;
HOST=$3;
DIR=$4; 
SYS_USER=$5; 


if [[ $EUID -ne 0 ]]; then
 msge "Please Run this Script as ROOT \n\t $ sudo su \n\t $ $DIR_SCRIPT/$FILE_SCRIPT  $INSTALL_MODE $CONFIRM $HOST $DIR $SYS_USER \n"; sudo su; exit;
fi 

if [ $INSTALL_MODE == 'Q' ]; then 
      echo -n "Enter Host Name (dummy.co.uk) : ";
      read HOST;
      echo -n "Enter Dir (/home/amzad/dev/dummy) : ";
      read DIR;
      echo -n "Enter System User (amzad) : ";
      read SYS_USER;
fi


msge "Host Name :  $HOST  \n" 
msge "Dir Selected :  $DIR \n" 
msge "System User :  $SYS_USER \n";
msge "Current File : $DIR_SCRIPT/$FILE_SCRIPT \n"

if [ $CONFIRM == 'C' ]; then  
      msge "\n\nCTRL+C to exit or \n"; 
      read -sn 1 -p 'Press any key to continue...';echo 
fi

## Comment the following line to run.
#exit 1

runAsDiffUser(){
   sudo -u $SYS_USER -H sh -c "$1";
}


DIR_WEB="$DIR/src/web";
DIR_HOSTFILE="/etc/apache2/sites-available";
DIR_SITE_ENABLE="/etc/apache2/sites-enabled";

#*** ADD a LINE TO /etc/hosts file....
## sudo vim /etc/hosts
## 127.0.0.1	dummy.co.uk
PATTERN="127.0.0.1   $HOST"
HOSTS="/etc/hosts"

#if grep -q $PATTERN $FILE;

if grep -Fxq "$PATTERN" $HOSTS;
 then  
	msge "$PATTERN already exist in $HOSTS \n" ;
 else 
	echo "$PATTERN"  >> $HOSTS;
	msge "$PATTERN added to $HOSTS"; 
fi

#*** Backup $DIR if exist.
if [ -d $DIR ]
 then
	mv $DIR $DIR"_Backup_"$NOW;
	msge "$DIR exist, renamed to $DIR/old_$NOW";  
fi 

runAsDiffUser "mkdir -m 755 -p $DIR"	
runAsDiffUser "mkdir -m 755 -p $DIR_WEB"

## Allowing permission to access the site... 
## Need to add dir accessable by apache group.
#sudo chown $SYS_USER:$SYS_USER -R  $DIR	
#chmod 755 -R $DIR


mkdir -m 777 $DIR/logfile 
#*** Creating error_log file and giving it 777 permission. 
runAsDiffUser "'$NOW	Log File Created.' >> $DIR/logfile/error_log "
chmod 777  $DIR/logfile/error_log

#*** Creating access_log file and giving it 777 permission. 
runAsDiffUser "'$NOW	Log File Created.' >> $DIR/logfile/access_log "
chmod 777  $DIR/logfile/access_log
 

# Create host file. Backup if exist... 
if [ -f $HOST.conf ]
	then
	sudo mv $DIR_HOSTFILE/$HOST.conf  $DIR_HOSTFILE/$HOST.conf__
fi

VHOST_DATA="<VirtualHost *:80>
     ServerName  $HOST
     DocumentRoot '$DIR_WEB'
     ErrorLog '$DIR/logfile/error_log'
     CustomLog '$DIR/logfile/access_log' common
     
    <Directory '$DIR_WEB'>
           Options FollowSymLinks MultiViews
           AllowOverride all
           AuthType None 
           Order deny,allow
           Allow from all
    </Directory>
</VirtualHost> 
# $NOW";


# creating /etc/apache2/sites-available/dummy.co.uk.conf
#EOF :: Should not have any SPACE before order after should be only ENTER.
cat > $DIR_HOSTFILE/$HOST.conf << EOF
$VHOST_DATA
EOF

msge "\n\n $VHOST_DATA >> $DIR_HOSTFILE/$HOST.conf  \n" 

## Enableing site via creating simlink in the following folder. 
##sudo a2ensite dummy.co.uk.conf
if [ -f $DIR_SITE_ENABLE/$HOST.conf ]
	then
	sudo rm $DIR_SITE_ENABLE/$HOST.conf  
fi

# Enable Site
sudo a2ensite $HOST.conf

## restart apache
sudo service apache2 restart



runAsDiffUser "touch $DIR_WEB/index.html"
echo " <h1> Welcome to $HOST </h1> Please EDIT this file @ $DIR_WEB " >> $DIR_WEB/index.html 

msge "Run Follwowing to remove this host\n
$ vim /etc/hosts # remove '$PATTERN'
$ rm -rf -R $DIR
$ rm $DIR_SITE_ENABLE/$HOST.conf
$ rm $DIR_HOSTFILE/$HOST.conf ";



## Red For Log File if there is any issue... !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


 
cd $DIR_SCRIPT
chmod 400 createVHost.sh
firefox "$HOST";




# http://stackoverflow.com/questions/19445686/ubuntu-server-apache-2-4-6-client-denied-by-server-configuration-php-fpm
# Order Deny,Allow
# Deny from all
# to
# Require all granted
















