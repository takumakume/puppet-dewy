# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "puppet"
gem "puppetlabs_spec_helper"
gem "rspec-puppet-facts"
gem "metadata-json-lint"

group :acceptance do
  gem "beaker"
  gem "beaker-docker"
  gem "beaker-rspec"
  gem "beaker-puppet_install_helper"
  gem "beaker-module_install_helper"
end
