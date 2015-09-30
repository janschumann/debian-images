#!/bin/bash
# Set up Vagrant.

# only on dev machines ...
if test -f .vbox_version || test -f linux.iso; then
  date > /etc/vagrant_box_build_time

  # Create the user vagrant with password vagrant
  useradd -G sudo -p $(perl -e'print crypt("vagrant", "vagrant")') -m -s /bin/bash -N vagrant

  # Install vagrant keys
  mkdir -pm 700 /home/vagrant/.ssh
  curl -Lo /home/vagrant/.ssh/authorized_keys \
    'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
  chmod 0600 /home/vagrant/.ssh/authorized_keys
  chown -R vagrant:vagrant /home/vagrant/.ssh

  # Customize the message of the day
  echo 'Welcome to your Vagrant-built virtual machine.' > /var/run/motd

  # Install NFS client
  apt-get -y install nfs-common

  # Set up sudo
  echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant
  groupadd -r admin
  usermod -a -G admin vagrant
  cp /etc/sudoers /etc/sudoers.orig
  sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
  sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers
fi
