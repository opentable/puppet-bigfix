# == Class: bigfix::install
#
# Module to install BigFix exe.

class bigfix::install(
  $package_version = $bigfix::package_version,
  $package_source = $bigfix::package_source
) inherits bigfix::params {

  validate_re($::osfamily, '^(Windows)$', 'This module can only work on Windows Systems.')
  validate_string($bigfix::install::package_version)
  validate_string($bigfix::install::params::package_source)

  $source = "${bigfix::install::package_source}/${bigfix::install::package_version}"

  case $::osfamily {
    'Windows': {
      package { 'BigFix Enterprise Client':
        ensure          => installed,
        provider        => windows,
        source          => $source,
        install_options => ['/s', '/v/qn']
      }
    }
    default: {
      fail('BigFix needs a Windows based system.')
    }
  }
}