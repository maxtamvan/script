#!/bin/bash

#Install Package
apt-get -y update && apt-get -y upgrade
apt-get -y install wget bzip2 make zlib1g-dev build-essential dropbear
dpkg-reconfigure locales

#Setting Dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/#DROPBEAR_PORT=22/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443"/g' /etc/default/dropbear

#Upgrade Dropbear
cd
mkdir UpDropbear-67
cd UpDropbear-67
wget "https://matt.ucc.asn.au/dropbear/releases/dropbear-2015.67.tar.bz2"
tar -xjf dropbear-2015.67.tar.bz2
cd dropbear-2015.67
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear1
ln /usr/local/sbin/dropbear /usr/sbin/dropbear

#Restart SSH & Dropbear
service ssh restart
service dropbear restart