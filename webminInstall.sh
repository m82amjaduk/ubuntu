#!/bin/bash
DIR_SCRIPT=$(pwd);
FILE_SCRIPT=$(basename $0);


cd ~
cd Packages


sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.580_all.deb
sudo dpkg -i webmin_1.580_all.deb

# https://127.0.0.1:10000


cd $DIR_SCRIPT;
msge "FILE :: $DIR_SCRIPT/$FILE_SCRIPT";
chmod 400 $DIR_SCRIPT/$FILE_SCRIPT;