#!/bin/bash

##### remove systemd until it is supported by puppet modules #######################################

# install sysvinit packages
apt-get -y install sysvinit-core sysvinit sysvinit-utils

# remove systemd -> has to be done after reboot so we do that in puppet
# apt-get remove --purge --auto-remove systemd

# prevent systemd packages to be installed
echo -e 'Package: systemd\nPin: origin ""\nPin-Priority: -1' > /etc/apt/preferences.d/systemd
echo -e 'Package: *systemd*\nPin: origin ""\nPin-Priority: -1' >> /etc/apt/preferences.d/systemd

####################################################################################################
