#!/bin/bash

# remove device map
rm /boot/grub/device.map

# Clean up
apt-get -y remove linux-headers-$(uname -r) build-essential
apt-get -y autoremove
apt-get -y clean

# cleanup history
history -c
