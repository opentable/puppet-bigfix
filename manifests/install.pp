# == Class: bigfix::install
#
# Module to install BigFix exe.

class bigfix::install {

  validate_re($::osfamily, '^(Windows)$', 'This module can only work on Windows Systems.')
  validate_string($bigfix::params::package_version)
  validate_string($bigfix::params::package_source)

  $source = "${bigfix::params::package_source}/${bigfix::params::package_version}"

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