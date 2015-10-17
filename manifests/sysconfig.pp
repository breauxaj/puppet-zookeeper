define zookeeper::sysconfig (
  $runas = 'zookeeper',
  $home = '/usr/local/zookeeper',
  $pid = '/var/run/zookeeper.pid'
) {
  include ::zookeeper

  file { '/etc/sysconfig/zookeeper':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zookeeper/sysconfig.erb'),
  }

}
