define zookeeper::service (
  $ensure = running,
  $enable = true
) {
  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => [ 'zookeeper' ],
  }

  service { $service:
    ensure  => $ensure,
    enable  => $enable,
  }

}
