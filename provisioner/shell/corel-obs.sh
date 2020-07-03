#!/bin/bash -eu
#############################################
### corel-awx : Vagrant Shell provisioner ###
#############################################
#-- Description
# Vagrant shell provisioner used to quickly deploy prometheus

###############
### Vagrant ###
###############
su - vagrant -c 'cp -r /vagrant/provisioner/docker/ /home/vagrant/'
su - vagrant -c 'cd /home/vagrant/docker && docker-compose up -d'
