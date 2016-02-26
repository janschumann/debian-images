#!/bin/bash

# determine debians release code name
CODENAME=$(lsb_release -c | awk '{print $2}')

# install puppet
wget http://apt.puppetlabs.com/puppetlabs-release-pc1-${CODENAME}.deb
dpkg -i puppetlabs-release-pc1-${CODENAME}.deb
apt-get -y update
apt-get -y install puppet-agent

# puppet 4 has a new install localtion and its binaries are not in the path
# so let´s add puppets new location to the PATH for everyone
echo "export PATH=\"\${PATH}:/opt/puppetlabs/bin\"" > /etc/profile.d/puppet.sh
chmod a+x /etc/profile.d/puppet.sh
# add it right now, so we do not have to re-login
/etc/profile.d/puppet.sh
