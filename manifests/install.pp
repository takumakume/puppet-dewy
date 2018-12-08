class dewy::install(
  $install_github_org      = $dewy::install_github_org,
  $install_github_repo     = $dewy::install_github_repo,
  $install_asset           = $dewy::install_asset,
  $version                 = $dewy::version,
  $bin_dir                 = $dewy::bin_dir,
  $user                    = $dewy::user,
  $group                   = $dewy::group,
) {
  if $version == 'latest' {
    $tag_name = $version
  } else {
    $tag_name = "v${version}"
  }

  $release = github_release_properties(
    $tag_name,
    "${install_github_org}/${install_github_repo}",
    $install_asset
  )
  archive { "/usr/local/src/${release[tag_name]}-${install_asset}":
    source       => $release[browser_download_url],
    cleanup      => false,
    extract      => true,
    extract_path => $bin_dir,
  }
  ~> file { "${bin_dir}/dewy":
    owner => $user,
    group => $group,
    mode  => '0755',
  }
}
