# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'nace-dev'

  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end

  config.vm.box = 'opscode-ubuntu-14.04'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

  config.vm.network :private_network, ip: "192.168.0.17"
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      postgresql: {
        password: {
          postgres: "devbox-password"
        }
      }
    }

    chef.run_list = [
      "postgresql::server",
      "solr::default",
      "nace-ckan::default"
    ]
  end
end
