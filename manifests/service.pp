define zookeeper::service (
  $ensure,
  $enable
) {
  include ::zookeeper

  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'zookeeper',
  }

  case $::osfamily {
    'redhat': {
      case $::lsbmajdistrelease {
        '6': {
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
        default: {
          include ::systemctl

          service { $service:
            ensure  => $ensure,
            enable  => $enable,
            require => File['/lib/systemd/system/zookeeper.service']
          }

          file { '/lib/systemd/system/zookeeper.service':
            ensure => present,
            owner  => 'root',
            group  => 'root',
            mode   => '0755',
            source => 'puppet:///modules/zookeeper/zookeeper.service'
          }

          file { '/etc/systemd/system/zookeeper.service':
            ensure  => 'link',
            owner   => 'root',
            group   => 'root',
            target  => '/lib/systemd/system/zookeeper.service'
          } ~>
          Exec['systemctl-daemon-reload']
        }
      }
    }
    default: {
      notify { 'OS not supported by this module': }
    }
  }

}