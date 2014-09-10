define zookeeper::config (
  $ticktime = '2000',
  $initlimit = '5',
  $synclimit = '2',
  $datadir = '/var/zookeeper',
  $clientport = '2181',
  $maxclientcnxns = '',
  $autopurge_snapretaincount = '',
  $autopurge_purgeinterval = ''
) {
  $config = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/usr/local/zookeeper/conf/zoo.cfg',
  }

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'zookeeper' ],
  }

  file { $config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zookeeper/zoo.erb'),
    notify  => Service[$service],
  }

  file { $datadir:
    ensure => directory,
    owner  => 'zookeeper',
    group  => 'zookeeper',
    mode   => '0755',
  }

}
