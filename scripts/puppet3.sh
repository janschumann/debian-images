#!/bin/bash

# determine debians release code name
CODENAME=$(lsb_release -c | awk '{print $2}')

# install puppet
wget http://apt.puppetlabs.com/puppetlabs-release-${CODENAME}.deb
dpkg -i puppetlabs-release-${CODENAME}.deb
apt-get -y update
apt-get -y install puppet facter
