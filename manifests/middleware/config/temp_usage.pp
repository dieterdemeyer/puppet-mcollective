define mcollective::middleware::config::temp_usage($limit='100 mb') {

  augeas { 'systemUsage/tempUsage' :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans/broker',
    changes => [
      "set systemUsage/systemUsage/tempUsage/tempUsage/#attribute/limit '${limit}'",
    ],
    onlyif  => "match systemUsage/systemUsage/tempUsage/tempUsage/#attribute/limit[. =\"${limit}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
