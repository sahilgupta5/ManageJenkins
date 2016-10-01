#!/bin/bash

HOSTNAME=$1

sudo ./updateServer.sh

sudo apt-get install language-pack-en

#Ensure that jenkins repository is trusted
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

#Get the list of sources for jenkins
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list.d/jenkins.list

#Run the update to make sure repo list is updated with Jenkins source repos
sudo apt-get update

#Install jenkins package
sudo apt-get install jenkins

#Install apache2 if not installed
sudo apt-get install apache2
sudo a2enmod proxy
sudo a2enmod proxy_http

cp jenkins.conf /etc/apache2/sites-available
sed -i "s/HOSTNAME/$1/g" /etc/apache2/sites-available/jenkins.conf

sudo a2ensite jenkins
sudo service apache2 reload
