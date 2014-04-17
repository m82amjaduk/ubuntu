#!/bin/bash

git init
git remote add origin $ORIGIN_URL;
git remote set-url origin $REMOTE_URL;
git config  user.name "Amzad Mojumder" ;
git config  user.email "amzad.FOF@gmail.com";
git config  credential.helper cache ;
git config  credential.helper "cache --timeout=36000" ;

git pull origin master	;
