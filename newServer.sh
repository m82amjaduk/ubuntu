#!/bin/bash

LOGDIR="/root/log/";
LOGFILE=$LOGDIR"install.log"
mkdir -p $LOGDIR

function log() {
    echo "\n Install " $1 " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< " &>> $LOGFILE
}

function yumIns() {
    log $i;
    yum install $1 -y &>> $LOGFILE;
    echo   $1 "\n ======================================= END " &>> $LOGFILE;
}

yumIns git;
yumIns curl;
yumIns zsh;
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm -Uhv rpmforge-release*.rf.x86_64.rpm
yumIns htop


yumIns  crontabs
service crond start
chkconfig crond on


log 'mysqld' ;  # INSTALL mysqld
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yumIns mysql-server
systemctl start mysqld
systemctl restart mysqld
systemctl status mysqld

log 'mysqld' ;  # INSTALL mysqld
yumIns bind bind-utils
