# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'nace-dev'

  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = '12.18.31'
  end

  config.vm.box = 'opscode-ubuntu-14.04'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

  config.vm.network :private_network, ip: "192.168.0.17"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 8983, host: 8983, auto_correct: true
  config.vm.network "forwarded_port", guest: 5000, host: 5000

  config.vm.synced_folder "ckanext-nasa_ace", "/usr/lib/ckan/default/src/ckanext-nasa_ace"
  config.vm.synced_folder "ckanext-group_private_datasets", "/usr/lib/ckan/default/src/ckanext-group_private_datasets"

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      ckan: {
        site_url: "http://localhost:8080",
        db_username: 'ckan_default',
        db_password: 'pass',
        db_address: '127.0.0.1',
        db_name: 'ckan_default',
        db_datastore_name: 'ckan_datastore',
        solr_url: 'localhost',
        system_user: 'vagrant',
        system_group: 'www-data',
        spatial_mapbox_token: "#{File.read('./.mapbox_token')}"
      },
      postgresql: {
        password: {
          postgres: "devbox-password"
        }
      },
      java: {
        jdk_version: '7'
      },
      solr: {
        data_dir: '/opt/solr-4.10.4/example/solr'
      }
    }

    chef.run_list = [
      "nace-ckan::database_server",
      "nace-ckan::solr",
      "nace-ckan::default"
    ]
  end
end
