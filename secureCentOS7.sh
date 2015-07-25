#!/bin/bash


# chmod +x /root/secureCentOS7.sh
# /root/secureCentOS7.sh 22 amzad



LOGDIR="/root/log/";
LOGFILE=$LOGDIR"secure.log"
mkdir -p $LOGDIR  /root/tmp/

cd /root/tmp/

SSH_PORT=$1     # '22'
USER=$2         #'amzad'


# Create User
adduser $USER  &>> $LOGFILE;
passwd $USER
id $USER  &>> $LOGFILE;
ls -lad /home/$USER/   &>> $LOGFILE;
echo $USER ' ALL=(ALL) ALL' >> /etc/sudoers  # Do Not Insert If exist.


# Modify sshd_config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.ORI  # Do not run if exist. /etc/issue.net
vim /etc/ssh/sshd_config
sed -i "s/#Port .*/Port 22/" /etc/ssh/sshd_config
sed -i "s/#PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
sed -i "s/#PubkeyAuthentication .*/PubkeyAuthentication yes/" /etc/ssh/sshd_config


sed -i "s/#Banner .*/Banner /etc/issue.net /" /etc/ssh/sshd_config  # Need to do this manually

rm  /etc/issue.net
echo "  ################################ " &>>  /etc/issue.net
echo "  ConosurTek Ltd Server "  `hostname` &>>  /etc/issue.net
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' &>> /root/ipadd.info  &>>  /etc/issue.net
echo "  ################################ " &>>  /etc/issue.net
cat  /etc/issue.net  &>> $LOGFILE;

/bin/systemctl restart  sshd.service  &>> $LOGFILE;
echo "END OF File... "  &>> $LOGFILE;
# Access as both amzad and root !!
#Banner none
echo $LOGFILE;
