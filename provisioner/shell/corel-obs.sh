#!/bin/bash -eu
#############################################
### corel-awx : Vagrant Shell provisioner ###
#############################################
#-- Description
# Vagrant shell provisioner used to quickly deploy prometheus

###############
### Vagrant ###
###############
su - vagrant -c 'mkdir -p /home/vagrant/prometheus && cp /vagrant/provisioner/docker/docker-compose.yml /home/vagrant/prometheus/docker-compose.yml && cp /vagrant/provisioner/docker/prometheus.yml /home/vagrant/prometheus/prometheus.yml'
su - vagrant -c 'cd /home/vagrant/prometheus && docker-compose up -d'
