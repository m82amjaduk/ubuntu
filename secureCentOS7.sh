#!/bin/bash


# chmod +x /root/scripts/secureCentOS7.sh
# /root/scripts/secureCentOS7.sh 22 amzad S1797
# /root/scripts/secureCentOS7.sh PortNo UserName hostname

NOW=$(date +'%Y-%m-%d-%T');

LOGDIR="/root/log/";
LOGFILE=$LOGDIR"secure.log"
mkdir -p $LOGDIR  /root/tmp/  /info

cd /root/tmp/;

echo &>> $LOGFILE;

SSHPORT=$1     # '22'
USER=$2         #'amzad'
HOSTNAME=$3     #'conTestC'
BANNER=/etc/banners.net;
SSHCON=/etc/ssh/sshd_config;


curl -q  http://icanhazip.com  > /info/ip;
IP=$(cat /info/ip);
echo ">>>>>>>>>>>>>>>   ./secureCentOS7.sh $1 $2 $3 $IP "  &>> $LOGFILE;
echo "cp /etc/ssh/sshd_config.ORI /etc/ssh/sshd_config;";
read -sn 1 -p 'Press CTRL+C to exit. And press any key to continue... ';echo


######################################  Create User
adduser $USER  &>> $LOGFILE;
passwd $USER; 
mkdir -p /home/$USER;
id $USER  &>> $LOGFILE;
ls -lad /home/$USER/   &>> $LOGFILE;
echo $USER ' ALL=(ALL) ALL' >> /etc/sudoers;  # TODO Do Not Insert If exist.



###################################### Set Host Name
QFD=$HOSTNAME".amzad.co";
echo $QFD >> $LOGFILE;
if ! grep  -r $QFD /etc/sysconfig/network;  then
	echo "HOSTNAME=$QFD" >> /etc/sysconfig/network;
fi
if ! grep  -r $QFD /etc/hosts;  then
	echo "$IP $QFD $HOSTNAME "  >> /etc/hosts;
fi
hostname $HOSTNAME;
/etc/init.d/network restart &>> $LOGFILE;


######################################  Modify sshd_config
cp $SSHCON $SSHCON.$NOW;
sed -i "s/#Port .*/Port $SSHPORT/" $SSHCON;
sed -i "s/#PermitRootLogin .*/PermitRootLogin no/" $SSHCON;
sed -i "s/#PubkeyAuthentication .*/PubkeyAuthentication yes/" $SSHCON;
sed -i "s/#Banner .*/Banner \/etc\/banners.net /"  $SSHCON;

rm  $BANNER;
echo "----------------------------------" &>>  $BANNER;
echo "ConosurTek Ltd Server "  &>>   $BANNER;
hostname   &>>   $BANNER;
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' &>> /root/ipadd.info  &>>  $BANNER;
echo "----------------------------------" &>>  $BANNER;
cat   $BANNER; &>> $LOGFILE;

/bin/systemctl restart  sshd.service  &>> $LOGFILE;

echo " >>>>>>>>>>>>>>>>>>> Incompleted Task" &>> $LOGFILE;
echo " Setup SWAP" &>> $LOGFILE;
echo " SetUp Firewall" &>> $LOGFILE;

# Time zone setup 
mv /etc/localtime /etc/localtime.$NOW;
ln -s /usr/share/zoneinfo/Europe/London /etc/localtime;
date &>> $LOGFILE;


################################ END 
echo "vim /etc/sysconfig/network " &>> $LOGFILE;
grep -r $QFD  /etc/sysconfig/network &>> $LOGFILE ; 
echo "vim /etc/hosts" &>> $LOGFILE;
grep -r $QFD  /etc/hosts &>> $LOGFILE ; 
echo "vim /etc/ssh/sshd_config " &>> $LOGFILE;
echo "<<<<<<<<<<<<<<<<<<< secureCentOS7.sh END $NOW "  &>> $LOGFILE;
echo " Access as both amzad and root !!"
echo "cat $LOGFILE | less ";



chmod 444 $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/$(basename $0);
