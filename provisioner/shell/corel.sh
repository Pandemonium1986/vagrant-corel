#!/bin/bash -eu
#############################################
### corel-cts : Vagrant Shell provisioner ###
#############################################
#-- Description
# Vagrant shell provisioner used to quickly instantiate an up to date vm with a
# minimum of software

###############
### Install ###
###############
dnf update -y
dnf install curl vim python3 git -y


##############
### Docker ###
##############
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sed -i s/enabled=1/enabled=1\\nmodule_hotfixes=1/g /etc/yum.repos.d/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
usermod -aG docker vagrant
docker run hello-world
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

###########
### Pip ###
###########
pip3 install ansible docker-compose

##################
### Prometheus ###
##################
mkdir -p /etc/prometheus/
touch /etc/prometheus/prometheus.yml
/bin/cat << EOF > /etc/prometheus/prometheus.yml
## my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
    - targets: ['localhost:9090']
  ## Scrape Config - Tower
  - job_name: 'tower'
    metrics_path: /api/v2/metrics
    scrape_interval: 5s
    scheme: http
    bearer_token: xxxxxxxxxxxxxxxx
    static_configs:
    - targets:
      - 192.168.66.100

  ## Add Node Exporter
  - job_name: 'tower-01'
    scrape_interval: 5s
    static_configs:
    - targets: ['192.168.66.100:9100']
EOF

###############
### Vagrant ###
###############
su - vagrant -c 'git clone -b 11.2.0 https://github.com/ansible/awx.git /home/vagrant/git/ansible/awx'
su - vagrant -c 'git clone https://github.com/redhat-cop/tower_grafana_dashboards  /home/vagrant/git/redhat-cop/tower_grafana_dashboards'
su - vagrant -c 'mkdir -p /home/vagrant/prometheus && cp /vagrant/dco-prometheus.yml /home/vagrant/prometheus/docker-compose.yml && cp /etc/prometheus/prometheus.yml /home/vagrant/prometheus/prometheus.yml'
# su - vagrant -c 'cd  /home/vagrant/git/ansible/awx/installer && ansible-playbook install.yml -i inventory'
# su - vagrant -c 'cd  /home/vagrant/git/redhat-cop/tower_grafana_dashboards && ansible-playbook install_node_exporter.yaml'
