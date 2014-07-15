define zookeeper::service (
  $ensure = running,
  $enable = true
) {
  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'zookeeper',
  }

  service { $service:
    ensure  => $ensure,
    enable  => $enable,
    require => File['/etc/init.d/zookeeper']
  }

  file { '/etc/init.d/zookeeper':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/zookeeper/zookeeper.init'
  }

}
