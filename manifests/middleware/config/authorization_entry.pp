define mcollective::middleware::config::authorization_entry($destination, $destination_content, $write, $read, $admin, $ensure='present') {

  if $ensure in [ 'present', 'absent' ] {
    $ensure_real = $ensure
  }
  else {
    fail("Mcollective::Middleware::Config::Authorization_entry[${title}]: parameter ensure must be present or absent")
  }

  if $destination in [ 'queue', 'topic' ] {
    $destination_real = $destination
  }
  else {
    fail("Mcollective::Middleware::Config::Authorization_entry[${title}]: parameter destination must be queue or topic")
  }

  case $ensure_real {
    'absent':
      {
        Augeas <| title == "plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry/${title}/rm" |>
      }
    'present':
      {
        Augeas <| title == "plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry/${title}/rm" |>

        augeas { "plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry/${title}/add" :
          lens    => 'Xml.lns',
          incl    => '/etc/activemq/activemq.xml',
          context => '/files/etc/activemq/activemq.xml',
          changes => [
            "set beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[last()+1]/#attribute/${destination_real} ${destination_content}",
            "set beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[last()]/#attribute/write ${write}",
            "set beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[last()]/#attribute/read ${read}",
            "set beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[last()]/#attribute/admin ${admin}",
          ],
          onlyif  => "match beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[#attribute/${destination_real}[. =\"${destination_content}\"] and #attribute/write[. = \"${write}\"] and #attribute/read[. = \"${read}\"] and #attribute/admin[. = \"${admin}\"]] size == 0",
          require => [ Augeas["plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry/${title}/rm"], Class['mcollective::middleware::config'] ],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry/${title}/rm" :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml',
    changes => [
      "rm beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[.][#attribute/${destination_real} = \"${destination_content}\"]",
    ],
    onlyif  => "match beans/broker/plugins/authorizationPlugin/map/authorizationMap/authorizationEntries/authorizationEntry[#attribute/${destination_real}[. =\"${destination_content}\"] and #attribute/write[. = \"${write}\"] and #attribute/read[. = \"${read}\"] and #attribute/admin[. = \"${admin}\"]] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
