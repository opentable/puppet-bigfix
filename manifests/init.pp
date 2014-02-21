# == Class: bigfix
#
# Module to install BigFix Client on Windows.
#
# === Parameters
#
# [*package_source*]
#   This is the default site to download your package from (e.g. http://files.nsclient.org/stable)
#
# [*package_version*]
#   This is version of the package to download (e.g. NSCP-0.4.1.101-x64.msi)

class bixfix(
  $package_source  = $bigfix::params::package_source,
  $package_version = $bigfix::params::package_version
) inherits bigfix::params {

  validate_re($::osfamily, '^(Windows)$', 'This module only works on Windows based systems.')
  validate_string($package_source)
  validate_string($package_version)

  class{'bigfix::install': } ->
  Class['bigfix']
}