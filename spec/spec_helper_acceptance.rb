require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

install_puppet_agent_on(hosts, {})

RSpec.configure do |c|
  c.formatter = :documentation
  c.before :suite do
    install_dev_puppet_module(module_name: 'dewy', source: File.expand_path(File.join(File.dirname(__FILE__), '..')))
  end
end
