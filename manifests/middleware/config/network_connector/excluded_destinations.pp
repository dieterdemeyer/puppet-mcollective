define mcollective::middleware::config::network_connector::excluded_destinations(
    $ensure = 'present',
    $queue  = [],
    $topic  = []
  ) {

  Augeas {
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => "/files/etc/activemq/activemq.xml/beans/broker/networkConnectors/networkConnector[#attribute/name = \"${title}\"]",
  }

  case $ensure {
    'absent': {
      augeas { "networkConnector/${title}/excludedDestinations":
        changes => [ 'rm excludedDestinations' ]
      }
    }
    'present': {
      if empty($queue) {
        augeas { "networkConnector/${title}/excludedDestinations/queue":
          changes => [
            'set excludedDestinations',
            'rm excludedDestinations/queue'
          ]
        }
      } else {
        augeas { "networkConnector/${title}/excludedDestinations/queue/${queue}":
          onlyif  => "match excludedDestinations/queue/#attribute/physicalName[. = \"${queue}\"] size == 0",
          changes => [
            'set excludedDestinations',
            "set excludedDestinations/queue[last()+1]/#attribute/physicalName \"${queue}\""
          ]
        }
      }

      if empty($topic) {
        augeas { "networkConnector/${title}/excludedDestinations/topic":
          changes => [
            'set excludedDestinations',
            'rm excludedDestinations/topic'
          ]
        }
      } else {
        augeas { "networkConnector/${title}/excludedDestinations/topic/${topic}":
          onlyif  => "match excludedDestinations/topic/#attribute/physicalName[. = \"${topic}\"] size == 0",
          changes => [
            'set excludedDestinations',
            "set excludedDestinations/topic[last()+1]/#attribute/physicalName \"${topic}\""
          ]
        }
      }
    }
    default: {
      fail("Mcollective::Middleware::Config::Network_connector::Excluded_destinations['${title}']: parameter ensure must be present or absent")
    }
  }
}
