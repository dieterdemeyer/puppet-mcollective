define mcollective::middleware::config::transport_connector($uri, $ensure='present') {

  if $ensure in [ 'present', 'absent' ] {
    $ensure_real = $ensure
  }
  else {
    fail("Mcollective::Middleware::Config::Transport_connector[${title}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        Augeas <| title == "transportConnectors/transportConnector/${title}/rm" |>
      }
    'present':
      {
        Augeas <| title == "transportConnectors/transportConnector/${title}/rm" |>

        augeas { "transportConnectors/transportConnector/${title}/add" :
          lens    => 'Xml.lns',
          incl    => '/etc/activemq/activemq.xml',
          context => '/files/etc/activemq/activemq.xml',
          changes => [
            "set beans/broker/transportConnectors/transportConnector[last()+1]/#attribute/name ${title}",
            "set beans/broker/transportConnectors/transportConnector[last()]/#attribute/uri ${uri}",
          ],
          onlyif  => "match beans/broker/transportConnectors/transportConnector[#attribute/name[. =\"${title}\"] and #attribute/uri[. = \"${uri}\"]] size == 0",
          require => [ Augeas["transportConnectors/transportConnector/${title}/rm"], Class['mcollective::middleware::config'] ],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "transportConnectors/transportConnector/${title}/rm" :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml',
    changes => [
      "rm beans/broker/transportConnectors/transportConnector[.][#attribute/name = \"${title}\"]",
    ],
    onlyif  => "match beans/broker/transportConnectors/transportConnector[#attribute/name[. =\"${title}\"] and #attribute/uri[. = \"${uri}\"]] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
