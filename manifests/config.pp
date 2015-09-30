define zookeeper::config (
  $value
) {
  include ::zookeeper

  $key = $title

  $context = '/files/etc/sysconfig/zookeeper'

  augeas { "zoo_sysconfig/${key}":
    context => $context,
    onlyif  => "get ${key} != '${value}'",
    changes => "set ${key} '${value}'",
  }

}