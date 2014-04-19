#!/bin/bash

#Installed Successfully.
# ubuntu 12.04


### http://www.howopensource.com/2012/11/install-insync-google-drive-client-in-ubuntu-12-10-12-04-ppa/

if [ -f /usr/bin/insync ]
    then
        echo "Hay Insync is already installed in your machine"
        exit
    else
        echo "It may take upto 10 min, PLEASE WAIT."
fi


cd temp

## wegt http://s.insynchq.com/builds/insync_1.0.27.31715_amd64.deb

echo "Enter ROOT Password when asked"
wget -O - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | sudo apt-key add -


echo "Add Insync repository to your apt repository"
sudo sh -c 'echo "deb http://apt.insynchq.com/ubuntu $(lsb_release -sc) non-free" >> /etc/apt/sources.list.d/insync.list'


echo "Update repository"
sudo apt-get update


echo "To install Insync in Ubuntu"
sudo apt-get install insync-beta-ubuntu

echo "Start insync "
/usr/bin/insync

echo " Thanks you for using this Script.  Enjoy !!!"