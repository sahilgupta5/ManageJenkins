#!/bin/bash
sleep 60
mkdir -p /usr/local/jenkins
cd /usr/local/jenkins

echo "Installing GIT" >> /var/log/configure-server.log
apt-get update
#Install git on the server
sudo apt-get --yes install git

echo "Installing CARMAISE" >> /var/log/configure-server.log
#Clone the repository to enable launching CARMAISE
git clone https://github.com/sahilgupta5/CARMAISE.git
sudo useradd jenkins
chown -R jenkins:jenkins /usr/local/jenkins/CARMAISE
chmod -R 777 /usr/local/jenkins/CARMAISE

echo "Installing Manage Jenkins Tools" >> /var/log/configure-server.log
#Clone the repository to setup Jenkins server
git clone https://github.com/sahilgupta5/ManageJenkins.git

cd ManageJenkins
echo "Installing updates" >> /var/log/configure-server.log
sudo ./updateServer.sh
echo "Installing jenkins and apache" >> /var/log/configure-server.log
sudo ./installJenkinsAndApache.sh
