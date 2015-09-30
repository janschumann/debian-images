#!/bin/bash


# only on dev machines ...
if test -f .vbox_version || test -f linux.iso; then

    # Removing leftover leases and persistent rules
    echo "cleaning up dhcp leases"
    rm /var/lib/dhcp/*

    # Make sure Udev doesn't block our network
    echo "cleaning up udev rules"
    rm /etc/udev/rules.d/70-persistent-net.rules
    mkdir /etc/udev/rules.d/70-persistent-net.rules
    rm -rf /dev/.udev/
    rm /lib/udev/rules.d/75-persistent-net-generator.rules

    echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
    echo "pre-up sleep 2" >> /etc/network/interfaces

fi

# Tweak sshd to prevent DNS resolution (speed up logins)
grep "UseDNS" /etc/ssh/sshd_config > /dev/null
if test $? -eq 0; then
    # sed yes to no
    sed -i 's/UseDNS \(.*\)/UseDNS no/' /etc/ssh/sshd_config
else
    echo -e "\nUseDNS no" >> /etc/ssh/sshd_config
fi
