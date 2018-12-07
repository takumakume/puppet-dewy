class dewy::install(
  $github_base_url = $dewy::github_base_url,
  $version         = $dewy::version,
  $asset           = $dewy::asset,
  $bin_dir         = $dewy::bin_dir,
  $user            = $dewy::user,
  $group           = $dewy::group,
) {
  exec { 'Install and extract':
    cwd     => '/tmp',
    command => "wget --no-check-certificate ${github_base_url}/v${version}/${asset} -O ${asset} && tar zxf ${asset} && mv -f dewy ${bin_dir}/dewy",
    unless  => "${bin_dir}/dewy --version | grep -Fqo ${version}",
    path    => ['/bin', '/usr/bin'],
  }

  -> file { "${bin_dir}/dewy":
    owner => $user,
    group => $group,
    mode  => '0755',
  }
}
