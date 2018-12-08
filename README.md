
# dewy

### example

```puppet
class { '::dewy':
  dir     => '/opt/dewy-testapp',
  command => 'server -r linyows/dewy-testapp -a dewy-testapp_linux_amd64.tar.gz -- /opt/dewy-testapp/current/dewy-testapp',
  user    => 'nobody',
  group   => 'nobody',
  require => File['/opt/dewy-testapp/current/dewy-testapp'],
}
```

### TODO:

- Document
- Fix acceptance tests