#!/bin/bash -eu
#############################################
### corel-cts : Vagrant Shell provisioner ###
#############################################
#-- Description
# Vagrant shell provisioner used to quickly instantiate an up to date vm with a
# minimum of software

###############
### Vagrant ###
###############
su - vagrant -c 'mkdir -p /home/vagrant/prometheus && cp /vagrant/dco-prometheus.yml /home/vagrant/prometheus/docker-compose.yml && cp /etc/prometheus/prometheus.yml /home/vagrant/prometheus/prometheus.yml'
# su - vagrant -c 'cd  /home/vagrant/git/ansible/awx/installer && ansible-playbook install.yml -i inventory'
# su - vagrant -c 'cd  /home/vagrant/git/redhat-cop/tower_grafana_dashboards && ansible-playbook install_node_exporter.yaml'
