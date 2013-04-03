define mcollective::middleware::config::memory_usage($limit='20 mb') {

  augeas { 'systemUsage/memoryUsage' :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml',
    changes => [
      "set beans/broker/systemUsage/systemUsage/memoryUsage/memoryUsage/#attribute/limit ${limit}",
    ],
    onlyif  => "match beans/broker/systemUsage/systemUsage/memoryUsage/memoryUsage/#attribute/limit[. =\"${limit}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
