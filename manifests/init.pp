class dewy(
  String $dir                       = '/opt/dewy-testapp',
  String $command                   = "server -r linyows/dewy-testapp -a dewy-testapp_linux_amd64.tar.gz -- ${dir}/current/dewy-testapp",

  String $install_github_org        = 'linyows',
  String $install_github_repo       = 'dewy',
  String $install_asset             = 'dewy_linux_amd64.tar.gz',
  String $version                   = 'latest',

  Integer $gomaxprocs               = 2,
  String $bin_dir                   = '/usr/bin',
  String $user                      = 'nobody',
  String $group                     = 'nobody',

  Optional[String] $github_endpoint = undef,
  Optional[String] $github_token    = undef,
  Optional[String] $slack_channel   = undef,
  Optional[String] $slack_token     = undef,
) {
  include dewy::install
  include dewy::config
  include dewy::service

  Class['dewy::install']
  -> Class['dewy::config']
  ~> Class['dewy::service']
}
