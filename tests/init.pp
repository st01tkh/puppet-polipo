class { 'polipo':
  proxyAddress => "${::ipaddress}",
}
