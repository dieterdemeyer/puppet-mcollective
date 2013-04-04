define mcollective::middleware::config::memory_usage($limit='20 mb') {

  augeas { 'systemUsage/memoryUsage' :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans/broker',
    changes => [
      "set systemUsage/systemUsage/memoryUsage/memoryUsage/#attribute/limit '${limit}'",
    ],
    onlyif  => "match systemUsage/systemUsage/memoryUsage/memoryUsage/#attribute/limit[. =\"${limit}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
