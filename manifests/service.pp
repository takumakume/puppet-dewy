class dewy::service {
  service { 'dewy':
    ensure => running,
    enable => true,
  }
}
