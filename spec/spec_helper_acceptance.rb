require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

# Install Puppet agent on all hosts
install_puppet_agent_on(hosts, {})

RSpec.configure do |c|
  c.formatter = :documentation
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.before :suite do
    # Install module to all hosts
    install_dev_puppet_module(source: module_root)

    # Install dependencies
    hosts.each do |host|
      on(host, puppet('module', 'install', 'puppet-archive'))
      on(host, puppet('module', 'install', 'takumakume-github_release_properties'))
    end
  end
end

