#!/bin/bash

CODENAME=$(lsb_release -c | awk '{print $2}')

echo ">> Removing old puppet"
aptitude -y purge puppet puppet-common puppetlabs-release facter
echo ">> Installing puppet master"
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-${CODENAME}.deb
dpkg -i puppetlabs-release-pc1-${CODENAME}.deb
apt-get -y update
apt-get -y install puppet-agent

# add puppets new location to the PATH for everyone
echo "export PATH=\"\${PATH}:/opt/puppetlabs/bin\"" > /etc/profile.d/puppet.sh
chmod a+x /etc/profile.d/puppet.sh
# add it right now, so we do not have to re-login
/etc/profile.d/puppet.sh
