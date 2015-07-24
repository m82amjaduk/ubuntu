#!/bin/bash

LOGDIR="/root/log/";
LOGFILE=$LOGDIR"install.log"
mkdir -p $LOGDIR /root/tmp/
cd /root/tmp/

function log() {
    echo   $1 " <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< " &>> $LOGFILE
}

function yumIns() {
    log $1;
    yum install $1 -y &>> $LOGFILE;
    echo   $1 "\n ======================================= END " &>> $LOGFILE;
}

yumIns git;
yumIns curl;
yumIns vim;

yumIns zsh;
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
sed -i "s/ZSH_THEME=.*/ ZSH_THEME='nanotech'/" /root/.zshrc         # change theam

wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm -Uhv rpmforge-release*.rf.x86_64.rpm
yumIns htop


yumIns  crontabs
service crond start
chkconfig crond on


wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
rpm -ivh mysql-community-release-el7-5.noarch.rpm
yumIns mysql-server
systemctl start mysqld  &>> $LOGFILE;
systemctl restart mysqld &>> $LOGFILE;
systemctl status mysqld &>> $LOGFILE;

yumIns bind bind-utils

cd /root

