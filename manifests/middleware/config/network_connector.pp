define mcollective::middleware::config::network_connector(
  $destinationhost=undef,
  $port='61616',
  $ssl=false,
  $username=undef,
  $password=undef,
  $duplex=true,
  $decrease_network_consumer_priority=true,
  $network_ttl='2',
  $dynamic_only=true,
  $ensure='present'
) {

  Augeas {
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans/broker',
  }

  if ($ssl == true) {
    $protocol="ssl"
  } else {
    $protocol="tcp"
  }

  $uri = "static:(${protocol}://${destinationhost}:${port})"

  if $ensure in [ 'present', 'absent' ] {
    $ensure_real = $ensure
  }
  else {
    fail("Mcollective::Middleware::Config::Network_connector[${title}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        Augeas <| title == "networkConnectors/networkConnector/${title}/rm" |>
      }
    'present':
      {
        if ($destinationhost == undef or $username == undef or $password == undef) {
          fail("Class[MCollective::Middleware::Config::Network_connector[${title}]: parameters destinationhost, username and password must be defined")
        }

        Augeas <| title == "networkConnectors/networkConnector/${title}/rm" |>

        augeas { "networkConnectors/networkConnector/${title}/add" :
          changes => [
            "set networkConnectors/networkConnector[last()+1]/#attribute/name ${title}",
            "set networkConnectors/networkConnector[last()]/#attribute/uri ${uri}",
            "set networkConnectors/networkConnector[last()]/#attribute/userName ${username}",
            "set networkConnectors/networkConnector[last()]/#attribute/password ${password}",
            "set networkConnectors/networkConnector[last()]/#attribute/duplex ${duplex}",
            "set networkConnectors/networkConnector[last()]/#attribute/decreaseNetworkConsumerPriority ${decrease_network_consumer_priority}",
            "set networkConnectors/networkConnector[last()]/#attribute/networkTTL ${network_ttl}",
            "set networkConnectors/networkConnector[last()]/#attribute/dynamicOnly ${dynamic_only}",
          ],
          onlyif  => "match networkConnectors/networkConnector[.][#attribute/name = \"${title}\" and #attribute/uri = \"${uri}\" and #attribute/userName = \"${username}\" and #attribute/password = \"${password}\"] size == 0",
          require => Augeas["networkConnectors/networkConnector/${title}/rm"],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "networkConnectors/networkConnector/${title}/rm" :
    changes => [
      "rm networkConnectors/networkConnector[.][#attribute/name = \"${title}\"]",
    ],
    onlyif  => "match networkConnectors/networkConnector[.][#attribute/name = \"${title}\" and #attribute/uri = \"${uri}\" and #attribute/userName = \"${username}\" and #attribute/password = \"${password}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
