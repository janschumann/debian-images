#!/bin/bash
# Update the box
apt-get -y update
apt-get -y install aptitude
aptitude -y update
aptitude -y safe-upgrade

# build tools
aptitude -y install linux-headers-$(uname -r) build-essential
aptitude -y install zlib1g-dev libssl-dev libreadline-gplv2-dev

# add some required packages
aptitude -y install curl unzip rsync
aptitude -y install apt-transport-https
