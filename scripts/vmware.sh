#!/bin/bash 

if test -f linux.iso ; then
  mount -o loop linux.iso /mnt
  tar -zxf $(ls /mnt/VMwareTools-*.tar.gz)
  cd vmware-tools-distrib
  # install with defaults
  ./vmware-install.pl --default
  # cleanup
  umount /mnt
  cd ..
  rm -Rf vmware-tools-distrib
  rm linux.iso
  # configure again and make sure the kernel modules are installed
  vmware-config-tools.pl -c -d 
  # start vmware services on startup
  update-rc.d vmware-tools defaults
fi
