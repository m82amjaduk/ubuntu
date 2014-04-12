#!/bin/bash
# Run $ chmod +x webminInstall.sh
# $ ./webminInstall.sh

DIR_SCRIPT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE_SCRIPT=$(basename $0);


cd ~/Packages

sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.580_all.deb
sudo dpkg -i webmin_1.580_all.deb

# https://127.0.0.1:10000


cd $DIR_SCRIPT;
echo "FILE :: $DIR_SCRIPT/$FILE_SCRIPT";
chmod 400 $DIR_SCRIPT/$FILE_SCRIPT;