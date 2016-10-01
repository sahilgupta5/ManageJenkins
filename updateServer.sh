# !/bin/bash

# Only run as root
if (( $EUID != 0 )); then
    exit
fi

apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get clean
apt-get -y autoremove
