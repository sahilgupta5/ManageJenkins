# !/bin/bash

sleep 120

sudo ./updateServer.sh

#Install git on the server
sudo apt-get -y install git

#Clone the repository to setup Jenkins server
git clone https://github.com/sahilgupta5/ManageJenkins.git

cd ManageJenkins

sudo ./installJenkins.sh
