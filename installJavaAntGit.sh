#!/bin/bash

#Add the repository
sudo apt-add-repository ppa:webupd8team/java
sudo apt-get --yes update

#Silently accept the Oracle Java 8 license agreement and install it
#Src:http://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
echo debconf shared/accepted-oracle-license-v1-1 select true | \
sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
sudo debconf-set-selections

sudo apt-get --yes install oracle-java8-installer
sudo apt-get --yes install git-core

sudo apt-get --yes install ant
sudo apt-get --yes install gradle

echo "Gradle Home: $(readlink -f /usr/bin/gradle)"
echo "Ant Home: $(readlink -f /usr/bin/ant)"
echo "Java Home: $(readlink -f /usr/bin/javac)"
