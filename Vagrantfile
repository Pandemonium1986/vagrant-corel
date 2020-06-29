# frozen_string_literal: true

Vagrant.configure('2') do |config|
  # Global configuration
  config.vm.box_check_update = true
  config.vm.communicator = 'ssh'
  config.vm.graceful_halt_timeout = 60

  config.vm.box = 'centos/8'
  config.vm.network 'private_network', ip: '192.168.66.100'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '8192'
    vb.name = 'corel-cts'
    vb.cpus = 2
  end

  config.vm.provision 'shell-corel', type: 'shell', run: 'once' do |shell|
    shell.path = 'provisioner/shell/corel.sh'
    shell.keep_color = 'true'
    shell.name = 'corel'
  end

  config.vm.hostname = 'corel-cts'
  config.vm.define 'corel-cts'
end
