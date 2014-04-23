#!/bin/bash

#Installed Successfully.
# ubuntu 12.04
echo " Thanks you for using this Script.  Enjoy !!!"
exit;

###############################################
## Download a better version from here ...
# http://confluence.jetbrains.com/display/PhpStorm/PhpStorm+Early+Access+Program

cd ~/temp
wget http://download.jetbrains.com/webide/PhpStorm-EAP-136.1672.tar.gz


###############################################
## Install Theam
cd ~/.WebIde80/config/colors
git clone https://github.com/cordoval/Symfony2Colors.git
cp Symfony2Colors/Symfony2.icls Symfony2.icls
# Restart PHPStorm
# Enable the theme
# Go to Settings->Editor->Colors & Fonts, select the Symfony2 scheme name, click OK


###############################################
## Keymap
# Reformat Code   # Conflict with Ubuntu, WAS: ctrl+alt+L, NEW: ctrl+alt+Q
# What is phpstorm caret??

###############################################
##  Settings >> Plugin >> Browse Repositories >> 
# Spell Checker English Dictionary
# Symfony 2 Clickable view 
# Symfony 2 Plugin
# php Annotations
# Eclipse Code Formatter


Enjoy!

