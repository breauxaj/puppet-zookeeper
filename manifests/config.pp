define zookeeper::config (
  $ticktime = '2000',
  $initlimit = '5',
  $synclimit = '2',
  $datadir = '/var/zookeeper',
  $clientport = '2181',
  $maxclientcnxns = '',
  $autopurge_snapretaincount = '',
  $autopurge_purgeinterval = '',
  $servers = ''
) {
  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/usr/local/zookeeper/conf/zoo.cfg',
  }

  $log4j = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/usr/local/zookeeper/conf/log4j.properties',
  }

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'zookeeper' ],
  }

  $myid = "${datadir}/myid"

  file { $config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zookeeper/zoo.erb'),
    notify  => Service[$service],
  }

  file { $log4j:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zookeeper/log4j.erb'),
    notify  => Service[$service],
  }

  file { $datadir:
    ensure => directory,
    owner  => 'zookeeper',
    group  => 'zookeeper',
    mode   => '0755',
  }

  file { $myid:
    ensure  => present,
    owner   => 'zookeeper',
    group   => 'zookeeper',
    mode    => '0644',
    content => '1',
    require => File[$datadir],
  }

}
