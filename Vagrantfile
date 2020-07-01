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

  # Provisioning configuration
  config.vm.provision 'ansible-corel-cts', type: 'ansible', run: 'once' do |ansible|
    ansible.compatibility_mode = '2.0'
    ansible.galaxy_role_file = 'provisioner/ansible/requirements.yml'
    ansible.playbook = 'provisioner/ansible/corel-cts.yml'
  end

  # Awx box
  config.vm.define 'corel-awx-cts' do |awx|
    awx.vm.box = 'centos/8'
    awx.vm.hostname = 'corel-awx-cts'
    awx.vm.network 'private_network', ip: '192.168.66.100'
    awx.vm.post_up_message = '
      #####################################
      ##   Starting corel-awx-cts done   ##
      #####################################
    '
    awx.vm.provision 'ansible-corel-awx', type: 'ansible', run: 'once' do |ansible|
      ansible.compatibility_mode = '2.0'
      ansible.galaxy_role_file = 'provisioner/ansible/requirements.yml'
      ansible.playbook = 'provisioner/ansible/corel-awx.yml'
    end
    awx.vm.provision 'shell-corel-awx', type: 'shell', run: 'once' do |shell|
      shell.path = 'provisioner/shell/corel-awx.sh'
      shell.keep_color = 'true'
      shell.name = 'shell-corel-awx'
    end
    awx.vm.provider :virtualbox do |vb|
      vb.memory = '4096'
      vb.name = 'corel-awx-cts'
      vb.customize ['modifyvm', :id, '--description', "
###############
### corel-awx-cts ###
###############
Centos 8 provisioned with :
 * Ansible
 * Awx
 * Docker"]
    end
  end

  # Observability box
  config.vm.define 'corel-obs-cts' do |obs|
    obs.vm.box = 'centos/8'
    obs.vm.hostname = 'corel-obs-cts'
    obs.vm.network 'private_network', ip: '192.168.66.101'
    obs.vm.post_up_message = '
      #####################################
      ##   Starting corel-obs-cts done   ##
      #####################################
    '
    obs.vm.provision 'shell-corel-obs', type: 'shell', run: 'once' do |shell|
      shell.path = 'provisioner/shell/corel-obs.sh'
      shell.keep_color = 'true'
      shell.name = 'shell-corel-obs'
    end
    obs.vm.provider :virtualbox do |vb|
      vb.memory = '2048'
      vb.name = 'corel-obs-cts'
      vb.customize ['modifyvm', :id, '--description', "
###############
### corel-obs-cts ###
###############
Centos 8 provisioned with :
 * Docker
 * Grafana
 * Prometheus"]
    end

  end
end
