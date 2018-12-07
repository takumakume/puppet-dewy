class dewy::config(
  $dir   = $dewy::dir,
  $user  = $dewy::user,
  $group = $dewy::group,
) {
  case $::osfamily {
    'Debian': {
      $sysconfig_dir    = '/etc/default'
      $systemd_unit_dir = '/lib/systemd/system'
    }
    default: {
      $sysconfig_dir    = '/etc/sysconfig'
      $systemd_unit_dir = '/usr/lib/systemd/system'
    }
  }

  file { $dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { "${sysconfig_dir}/dewy":
    content => template('dewy/dewy.sysconfig.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['dewy::service'],
  }

  file { "${systemd_unit_dir}/dewy.service":
    content => template('dewy/dewy.service.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['dewy::service'],
  }
}
