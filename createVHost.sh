#!/bin/bash


## Run :: chmod 777 /home/amzad/Dropbox/Scripts/dnnfashion/setupFresh.sh
## Run :: chmod 400 /home/amzad/Dropbox/Scripts/dnnfashion/setupFresh.sh
## Run :: /home/amzad/Dropbox/Scripts/dnnfashion/setupFresh.sh dnnfashion.co.uk dnnfashion 


######## Config
DOMAIN=$1; # dnnfashion.co.uk";
GITHUB_REPOSITORIES=$2 # "dnnfashion";

GITHUB_REPOSITORIES_OWNER="m82amjaduk";
CONFIG_USERNAME="Amzad Mojumder";
CONFIG_EMAIL="amzad.fof@gmail.com";

VHOST_SCRIPT="/home/amzad/Dropbox/Scripts/tools/toolsScripts/createVHost.sh";
#####################################
LOCAL_REPOSITORIES="/home/amzad/dev/$GITHUB_REPOSITORIES";
ORIGIN_URL="git@github.com:$GITHUB_REPOSITORIES_OWNER/$GITHUB_REPOSITORIES.git"; 

# Root Password for Rack Space :: a7fD45c3avq9

# Setup a fresh Project...
chmod +x $VHOST_SCRIPT;
echo "Please run the following line on a new CLI tab \n";
echo "$VHOST_SCRIPT q c $DOMAIN $LOCAL_REPOSITORIES amzad";
read -sn 1 -p 'Press any key to continue...';echo

### Get Symfony Rep
cd $LOCAL_REPOSITORIES 
rm -rf R src
mkdir -m 777 src 
curl -sS https://getcomposer.org/installer | php
php composer.phar create-project symfony/framework-standard-edition src 2.2.9 
mv composer.phar src/
cd src
chmod 777 -R app/cache app/logs




# sudo su;
# echo "#### Default Value was On, Chnaged to Off. amzad.fof@gmail.com" >> /etc/php5/apache2/php.ini
# echo "short_open_tag" >> /etc/php5/apache2/php.ini
# echo "   Default Value: Off" >> /etc/php5/apache2/php.ini
# echo "   Development Value: Off" >> /etc/php5/apache2/php.ini
# echo "   Production Value: Off" >> /etc/php5/apache2/php.ini

# echo "####  'date.timezone = '; Changed to 'date.timezone = Europe/Paris'  amzad.fof@gmail.com" >> /etc/php5/apache2/php.ini 
#  echo "date.timezone = Europe/London" >> /etc/php5/apache2/php.ini  
## set "short_open_tag = Off" >> /etc/php5/apache2/php.ini 
# su amzad



mysqladmin -uroot -pamjad123 create dnnfashion; 

# http://dnnfashion.co.uk/app_dev.php/_configurator/step/0 

cd $LOCAL_REPOSITORIES ## dnnfashion 
# cd /home/amzad/dev/dnnfashion
mkdir -m 777 logfile
touch logfile/error_log logfile/access_log
chmod 777 -R logfile


sudo rm -rf -R .git
git init
git remote add origin $ORIGIN_URL;
# git remote add origin "git@github.com:m82amjaduk/dnnfashion.git"
git config  user.name "$CONFIG_USERNAME" ;
# git config  user.name "Amzad Mojumder"
git config  user.email "$CONFIG_EMAIL";
# git config user.email "amzad.fof@gmail.com" 
git config  credential.helper cache ;
git config  credential.helper "cache --timeout=ll
36000";
git config --global color.ui true
git config push.default current

wget https://raw2.github.com/m82amjaduk/ubuntu/master/.gitignore -P src/
git add .
git commit -m "first commit"
git push -u origin master


echo "logfile/" >> .gitignore  

firefox http://dnnfashion.co.uk/app_dev.php

