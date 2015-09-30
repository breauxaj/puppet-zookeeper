class zookeeper (
  $version = '3.4.6',
  $source = 'http://www.us.apache.org/dist/zookeeper/stable/'
){
  exec { 'get-zoo':
    path    => '/bin:/usr/bin',
    command => "wget ${source}/zookeeper-${version}.tar.gz",
    cwd     => '/tmp',
    creates => "/tmp/zookeeper-${version}.tar.gz",
    timeout => 10000,
    onlyif  => "test ! -d /usr/local/zookeeper-${version}",
  }

  exec { 'untar-zoo':
    path    => '/bin:/usr/bin',
    command => "tar -zxf /tmp/zookeeper-${version}.tar.gz",
    cwd     => '/usr/local',
    creates => "/usr/local/zookeeper-${version}",
    timeout => 10000,
    require => Exec['get-zoo'],
  }

  file { "/usr/local/zookeeper-${version}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    recurse => true,
    require => Exec['untar-zoo'],
  }

  file { '/usr/local/zookeeper':
    ensure  => 'link',
    owner   => 'root',
    group   => 'root',
    target  => "/usr/local/zookeeper-${version}",
    require => Exec['untar-zoo'],
  }
  
  file { '/etc/profile.d/zookeeper.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'export ZK_HOME=/usr/local/zookeeper',
  }

  group { 'zookeeper':
    ensure => present,
    gid    => 2181,
  }

  user { 'zookeeper':
    ensure     => present,
    gid        => 2181,
    home       => '/var/lib/zookeeper',
    shell      => '/bin/bash',
    managehome => true,
    uid        => 2181,
  }

}