# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  [:app, :riak1, :riak2, :riak3].each_with_index do |node, i|
    config.vm.define node do |node_config|
      node_config.vm.box = "centos-6.5-x86_64"
      node_config.vm.box_url = "http://download.reaktor.fi/devopskoulu/vagrant/centos-6.5-x86_64_virtualbox.box"
      node_config.vm.hostname = "#{node.to_s}.vagrant.local"
      node_config.vm.network :private_network, ip: "10.10.10.#{10+i}"

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512"]
      end

      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "site.pp"
        puppet.module_path = "modules"
        #puppet.options = "--verbose --debug"
      end
    end
  end
end
