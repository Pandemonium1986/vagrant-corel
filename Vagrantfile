# frozen_string_literal: true

Vagrant.configure('2') do |config|
  # Global configuration
  config.vm.box_check_update = true
  config.vm.communicator = 'ssh'
  config.vm.graceful_halt_timeout = 60

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--audio', 'none']
    vb.customize ['modifyvm', :id, '--boot1', 'dvd']
    vb.customize ['modifyvm', :id, '--boot2', 'disk']
    vb.customize ['modifyvm', :id, '--boot3', 'none']
    vb.customize ['modifyvm', :id, '--boot4', 'none']
    vb.customize ['modifyvm', :id, '--groups', '/Corel']
    vb.customize ['modifyvm', :id, '--vram', '64']
    vb.gui = false
    vb.linked_clone = false
    vb.memory = '1024'
  end

  # Ansible box
  config.vm.define 'corel-ans-cts' do |ans|
    ans.vm.box = 'centos/8'
    ans.vm.hostname = 'corel-ans-cts'
    ans.vm.network 'private_network', ip: '192.168.66.100'
    ans.vm.post_up_message = '
#####################################
##   Starting corel-ans-cts done   ##
#####################################
'
    ans.vm.provision 'ansible-corel-ans', type: 'ansible', run: 'once' do |ansible|
      ansible.compatibility_mode = '2.0'
      ansible.galaxy_role_file = 'provisioner/ansible/requirements.yml'
      ansible.playbook = 'provisioner/ansible/corel-ans.yml'
    end
    ans.vm.provider :virtualbox do |vb|
      vb.name = 'corel-ans-cts'
      vb.customize ['modifyvm', :id, '--description', "
###############
### corel-ans-cts ###
###############
Vagrant Box
Centos 8 provided with my basic tools and ansible."]
    end
  end

  # Awx/Prometheus/Grafana box
  config.vm.define 'corel-tls-cts' do |tls|
    tls.vm.box = 'centos/8'
    tls.vm.hostname = 'corel-tls-cts'
    tls.vm.network 'private_network', ip: '192.168.66.101'
    # tls.vm.provision 'shell-corel', type: 'shell', run: 'once' do |shell|
    #   shell.path = 'provisioner/shell/corel.sh'
    #   shell.keep_color = 'true'
    #   shell.name = 'corel'
    # end
    tls.vm.provision 'ansible-corel-tls', type: 'ansible', run: 'once' do |ansible|
      ansible.compatibility_mode = '2.0'
      ansible.galaxy_role_file = 'provisioner/ansible/requirements.yml'
      ansible.playbook = 'provisioner/ansible/corel-tls.yml'
    end
    tls.vm.post_up_message = '
#####################################
##   Starting corel-tls-cts done   ##
#####################################
 '
    tls.vm.provider :virtualbox do |vb|
      vb.memory = '8192'
      vb.name = 'corel-tls-cts'
      vb.customize ['modifyvm', :id, '--description', "
###############
### corel-tls-cts ###
###############
Vagrant Box
Centos 8 provided with docker and docker-compose."]
    end
  end
end
