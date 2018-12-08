module VagrantPlugins
  module LibrarianPuppet
    class Plugin < Vagrant.plugin(2)
      name 'vagrant-librarian-puppet'
      description 'Installation of Puppet modules via librarian-puppet'
      action_hook 'librarian_puppet' do |hook|
        hook.before Vagrant::Action::Builtin::Provision, Action
      end
    end

    class Action
      def initialize(app, _)
        @app = app
      end

      def call(env)
        env[:ui].info 'Running pre-provisioner: librarian-puppet...'

        Vagrant::Util::Env.with_clean_env do
          ENV.reject! { |_, v| v.match %r{vagrant}i }
          cmd = 'bundle exec librarian-puppet install --path tests/modules --verbose'
          env[:ui].detail `#{cmd}`
        end

        @app.call(env)
      end
    end
  end
end

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  require 'fileutils'
  FileUtils.mkdir_p 'tests/modules'

  require 'json'
  metadata = JSON.parse(File.read('metadata.json'))
  module_name = metadata['name'].split('-').last

  config.vm.provision :shell,
                      inline: "ln -sfn /vagrant/ /vagrant/tests/modules/#{module_name}"

  config.vm.provision :puppet do |puppet|
    puppet.environment_path = '.'
    puppet.environment      = 'tests'
    puppet.module_path      = 'tests/modules'
    puppet.options          = [
      '--detailed-exitcodes',
      '--test',
    ]
    puppet.hiera_config_path = 'tests/hiera.yaml'
  end

  def define_vbox(c, private_ip: nil, memory: 256, cpu: 2)
    c.vm.network :private_network, ip: private_ip if private_ip

    c.vm.provider :virtualbox do |vbox|
      vbox.customize ['modifyvm', :id, '--memory', memory]
      vbox.customize ['modifyvm', :id, '--cpus',   cpu]

      vbox.customize ['modifyvm', :id, '--hpet', 'on']
      vbox.customize ['modifyvm', :id, '--acpi', 'off']

      vbox.customize ['modifyvm', :id, '--natdnsproxy1', 'off']
      vbox.customize ['modifyvm', :id, '--natdnshostresolver1', 'off']
    end
  end

  config.vm.define "centos7-dewy" do |c|
    c.vm.box       = 'puppetlabs/centos-7.2-64-puppet'
    c.vm.host_name = "centos7-dewy"
    define_vbox c, private_ip: "192.168.4.10"
  end
end
