#!/bin/bash

PUBLIC_HOSTNAME=$(curl http://169.254.169.254/latest/meta-data/public-hostname)

while true;
do
if [ "$(curl http://169.254.169.254/latest/meta-data/public-hostname)x"!="x" ]; then
	break;
fi
sleep 5;
done

sudo apt-get --yes install language-pack-en

#Ensure that jenkins repository is trusted
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

#Get the list of sources for jenkins
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list.d/jenkins.list

#Run the update to make sure repo list is updated with Jenkins source repos
sudo apt-get --yes update

#Install jenkins package
sudo apt-get --yes install jenkins

#Install apache2 if not installed
sudo apt-get --yes install apache2
sudo a2enmod proxy
sudo a2enmod proxy_http

cp jenkins.conf /etc/apache2/sites-available
sed -i "s/HOSTNAME/$PUBLIC_HOSTNAME/g" /etc/apache2/sites-available/jenkins.conf

sudo a2ensite jenkins
sudo service apache2 reload

#Install AWS Cli Tools
sudo apt-get --yes install awscli
sudo apt-get --yes install jq
