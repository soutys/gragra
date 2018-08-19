# -*- mode: ruby -*-
# vi: ft=ruby:ts=4:sw=4:et:fdm=indent:ff=unix

# see: https://github.com/tknerr/vagrant-managed-servers
# see: https://github.com/lowescott/learning-tools/blob/master/vagrant/multi-provider

Vagrant.require_version ">= 1.9.1"

VAGRANTFILE_API_VERSION = "2"
VAGRANTFILE_DEF_PROVIDER = "virtualbox"

#require "vagrant-managed-servers"
require "yaml"

machines = YAML.load_file(File.join(File.dirname(__FILE__), "machines.yml"))

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "tknerr/managed-server-dummy"

    config.vm.provider VAGRANTFILE_DEF_PROVIDER do |provider, override|
        provider.gui = false
    end

    machines.each do |machine|
        config.vm.define machine["name"] do |srv|

            # Specify the hostname of the machine
            srv.vm.hostname = machine["name"]

            # Don"t check for box updates
            srv.vm.box_check_update = false

            # Disable default shared folder
            srv.vm.synced_folder ".", "/vagrant", disabled: true

            config.vm.provision "ansible" do |ansible|
                ansible.playbook = "provision/ansible/" + (ENV["ANSIBLE_PROVIDER"] || VAGRANTFILE_DEF_PROVIDER) + ".yml"
                ansible.inventory_path = "provision/ansible/" + (ENV["ANSIBLE_PROVIDER"] || VAGRANTFILE_DEF_PROVIDER) + "_hosts"
                ansible.host_key_checking = false
                ansible.verbose = "vv"
                ansible.compatibility_mode = "2.0"
                ansible.host_vars = {
                  "default" => {
                    "ansible_python_interpreter" => "/usr/bin/python2"
                  }
                }
            end

            # Set per-machine VirtualBox provider configuration/overrides
            srv.vm.provider :virtualbox do |provider, override|
                provider.name = machine["name"]
                provider.customize ["modifyvm", :id, "--memory", "1024"]
                provider.customize ["modifyvm", :id, "--ioapic", "on"]
                provider.customize ["modifyvm", :id, "--cpus", "2"]
                override.vm.box = machine["box"]["virtualbox"]

                config.vm.network :forwarded_port, guest: 80, host: 8080
                config.vm.network :forwarded_port, guest: 443, host: (ENV["GRAPHITE_COLLECTOR_PORT"] || 8443).to_i
                config.vm.network :forwarded_port, guest: 3000, host: 13000
            end # srv.vm.provider "virtualbox"

            # Set per-machine managed-server provider configuration/overrides
            srv.vm.provider :managed do |provider, override|
                provider.server = machine["server_host"]["managed"]
                override.vm.box = machine["box"]["managed"]
                override.ssh.port = (ENV["MANAGED_SSH_PORT"] || 22).to_i
            end # srv.vm.provider "managed"

        end # config.vm.define
    end # machines.each
end # Vagrant.configure
