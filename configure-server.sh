#!/bin/bash
sleep 60
mkdir -p /usr/local/jenkins
cd /usr/local/jenkins
#Install git on the server
sudo apt-get --yes install git

#Clone the repository to enable launching CARMAISE
git clone https://github.com/sahilgupta5/CARMAISE.git
chown -R jenkins:jenkins /usr/local/jenkins/CARMAISE
chmod -R 777 /usr/local/jenkins/CARMAISE

#Clone the repository to setup Jenkins server
git clone https://github.com/sahilgupta5/ManageJenkins.git

cd ManageJenkins
sudo ./updateServer.sh
sudo ./installJenkinsAndApache.sh
