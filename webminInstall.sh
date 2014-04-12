#!/bin/bash
cd ~
cd Packages


sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.580_all.deb
sudo dpkg -i webmin_1.580_all.deb

# https://127.0.0.1:10000
