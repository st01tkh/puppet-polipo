class polipo(
  $proxyAddress = undef,
  $allowedClients = undef,
  $proxyname = undef,
  $parentProxy = undef,
  $socksParentProxy = undef,
  $socksProxyType = undef,
  $chunkHighMark = 819200,
  $objectHighMark = 128,
  $diskCacheRoot = undef,
  $maxDiskCacheEntrySize = undef,
  $forbiddenURLs = undef,
  $options = ['any'],
  $p_loglevel = undef,
) inherits ::polipo::params {

  if $chunkHighMark { validate_re($chunkHighMark, '[0-9]+') }
  if $objectHighMark { validate_re($objectHighMark, '[0-9]+') }
  validate_array($options)
  if $parentProxy { validate_string($parentProxy) }
  if $socksParentProxy{ validate_string($socksParentProxy) }
  if $socksProxyType { validate_string($socksProxyType) }
  if $proxyAddress { validate_string($proxyAddress) }
  if $allowedClients { validate_string($allowedClients) }
  if $proxyname { validate_string($proxyname) }
  if $diskCacheroot { validate_absolute_path($diskCacheRoot) }
  if $maxDiskCacheEntrySize { validate_re($maxDiskCacheEntrySize, '[0-9]+') }
  if $forbiddenURLs { validate_string($forbiddenURLs) }
  if $p_loglevel { validate_string($p_loglevel, '0x[0-9]+') }

  package { $::polipo::package: ensure => installed, }

  file { $::polipo::config_file:
    ensure => file,
    content => template("${module_name}/config.erb"),
    require => Package[$::polipo::package],
  }

  file { '/etc/polipo/forbidden':
    ensure => file,
    content => template("${module_name}/forbidden.erb"),
    require => Package[$::polipo::package],
  }

  file { '/etc/polipo/options':
    ensure => file,
    content => template("${module_name}/options.erb"),
    require => Package[$::polipo::package],
  }

  service { $service:
    ensure => running,
    enable => true,
    hasstatus => false,
    subscribe => File[$::polipo::config_file],
  }
}
