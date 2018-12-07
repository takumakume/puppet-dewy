class dewy(
  String $dir                     = '/opt/dewy-testapp',
  String $command                 = "server -r linyows/dewy-testapp -a dewy-testapp_linux_amd64.tar.gz -- ${dir}/current/dewy-testapp",
  String $github_base_url         = 'https://github.com/linyows/dewy/releases/download',
  String $version                 = '0.5.0',
  String $asset                   = 'dewy_linux_amd64.tar.gz',
  String $user                    = 'nobody',
  String $group                   = 'nobody',
  String $bin_dir                 = '/usr/bin',
  String $github_endpoint         = 'https://api.github.com',
  String $github_token            = '',
  Optional[String] $slack_token   = undef,
  Optional[String] $slack_channel = undef,
) {
  include dewy::install
  include dewy::config
  include dewy::service

  Class['dewy::install']
  -> Class['dewy::config']
  ~> Class['dewy::service']
}
