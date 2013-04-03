define mcollective::middleware::config::network_connector(
  $uri,
  $username,
  $password,
  $duplex='true',
  $decrease_network_consumer_priority='true',
  $network_ttl='2',
  $dynamic_only='true',
  $conduit_subscriptions='true',
  $ensure='present'
) {

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
        Augeas <| title == "networkConnectors/networkConnector/${title}/rm" |>

        augeas { "networkConnectors/networkConnector/${title}/add" :
          lens    => 'Xml.lns',
          incl    => '/etc/activemq/activemq.xml',
          context => '/files/etc/activemq/activemq.xml',
          changes => [
            "set beans/broker/networkConnectors/networkConnector[last()+1]/#attribute/name ${title}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/uri ${uri}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/userName ${username}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/password ${password}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/duplex ${duplex}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/decreaseNetworkConsumerPriority ${decrease_network_consumer_priority}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/networkTTL ${network_ttl}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/dynamicOnly ${dynamic_only}",
            "set beans/broker/networkConnectors/networkConnector[last()]/#attribute/conduitSubscriptions ${conduit_subscriptions}",
            "set beans/broker/networkConnectors/networkConnector[last()]/excludedDestinations/queue/#attribute/physicalName '>'",
          ],
          onlyif  => "match beans/broker/networkConnectors/networkConnector[#attribute/name[. =\"${title}\"] and #attribute/uri[. = \"${uri}\"] and #attribute/userName[. = \"${username}\"] and #attribute/password[. = \"${password}\"] and #attribute/conduitSubscriptions[. = \"${conduit_subscriptions}\"]] size == 0",
          require => Augeas["networkConnectors/networkConnector/${title}/rm"],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "networkConnectors/networkConnector/${title}/rm" :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml',
    changes => [
      "rm beans/broker/networkConnectors/networkConnector[.][#attribute/name = \"${title}\"]",
    ],
    onlyif  => "match beans/broker/networkConnectors/networkConnector[#attribute/name[. =\"${title}\"] and #attribute/uri[. = \"${uri}\"] and #attribute/userName[. = \"${username}\"] and #attribute/password[. = \"${password}\"] and #attribute/conduitSubscriptions[. = \"${conduit_subscriptions}\"]] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
