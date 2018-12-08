class { '::dewy':
  dir     => '/var/tmp/dewy-testapp',
  command => 'server -r linyows/dewy-testapp -a dewy-testapp_linux_amd64.tar.gz -- /var/tmp/dewy-testapp',
  user    => 'nobody',
  group   => 'nobody',
  require => File['/var/tmp/dewy-testapp'],
}
