Vagrant.configure(2) do |config|

  config.vm.box = 'ebrc/irods-ebrc-prod-model'
  config.vm.box_url = 'http://software.apidb.org/vagrant/irods-ebrc-prod-model.json'

  config.ssh.forward_agent = true

  if Vagrant.has_plugin?('landrush')
   config.landrush.enabled = true
   config.landrush.tld = 'vm'
  end

  # iRODS is pre-configured to this hostname.
  config.vm.hostname = 'ies.irods.vm'

  # ensure there's no environment file left over from
  # the source box.
  config.vm.provision 'shell',
    inline: 'rm -rf /home/vagrant/.irods'

  config.vm.provision "shell",
    path: 'cleanup_remote_resources.sh'

end
