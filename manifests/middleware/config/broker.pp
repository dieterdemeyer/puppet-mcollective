define mcollective::middleware::config::broker($use_jmx=true, $schedule_period_for_destination_purge='60000') {

  augeas { 'beans/broker' :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans',
    changes => [
      "set broker/#attribute/brokerName ${name}",
      "set broker/#attribute/useJmx ${use_jmx}",
      "set broker/#attribute/schedulePeriodForDestinationPurge ${schedule_period_for_destination_purge}",
    ],
    onlyif  => "match broker[#attribute/brokerName[. = \"${name}\"] and #attribute/useJmx[. = \"${use_jmx}\"] and #attribute/schedulePeriodForDestinationPurge[. = \"${schedule_period_for_destination_purge}\"]] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
