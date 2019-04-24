# puppet-polipo

Install and configure polipo caching web proxy.

Currently only supports ::osfamily Debian.

Note that this module was previously named nvpuppet/polipo.

## Usage 

```
  class { 'polipo':
    chunkHighMark => 819200,
    objectHighMark => 128,
    proxyAddress => '::0',
    socksParentProxy => '127.0.0.1:9050',
    socksProxyType = 'socks5',
    allowedClients => '127.0.0.1, 192.168.0.0/16',
    p_loglevel => '0xFF',
    maxDiskCacheEntrySize => '-1',
  }

```

where:

```
    proxyAddress => '::0',
    allowedClients => '127.0.0.1, 192.168.0.0/16', 

```

## Bug reports
Please file bug reports to Issues on GitHub.

## Contact
Nathan R Valentine <nathan@puppetlabs.com> | <nrvale0@gmail.com>
st01tkh <st01tkh@gmail.com> | <st01tkh@gmail.com>
