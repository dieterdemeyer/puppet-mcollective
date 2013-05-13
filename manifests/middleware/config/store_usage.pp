define mcollective::middleware::config::store_usage($limit='1 gb') {

  augeas { 'systemUsage/storeUsage' :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans/broker',
    changes => [
      "set systemUsage/systemUsage/storeUsage/storeUsage/#attribute/limit '${limit}'",
    ],
    onlyif  => "match systemUsage/systemUsage/storeUsage/storeUsage/#attribute/limit[. =\"${limit}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
