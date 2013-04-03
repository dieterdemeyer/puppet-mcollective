define mcollective::middleware::config::store_usage($limit='1 gb') {

  augeas { 'systemUsage/storeUsage' :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml',
    changes => [
      "set beans/broker/systemUsage/systemUsage/storeUsage/storeUsage/#attribute/name $name",
      "set beans/broker/systemUsage/systemUsage/storeUsage/storeUsage/#attribute/limit $limit",
    ],
    onlyif  => "match beans/broker/systemUsage/systemUsage/storeUsage/storeUsage[#attribute/limit[. =\"$limit\"] and #attribute/name[. =\"$name\"]] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
