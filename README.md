zookeeper
=========

ZooKeeper is a centralized service for maintaining configuration information,
naming, providing distributed synchronization, and providing group services.

Samples
-------
```
include zookeeper
```
```
zookeeper::service { 'default': ensure => running, enable => true }
```
```
zookeeper::config {
  "RUNAS":          value => 'zookeeper';
  "ZOOKEEPER_HOME": value => '/usr/local/zookeeper';
  "ZOOKEEPER_PID":  value => '/var/run/zookeeper.pid';
}
```

License
-------
GPL3

Contact
-------
breauxaj AT gmail DOT com
