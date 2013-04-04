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
        Augeas <| title == "authorizationEntry/${title}/rm" |>
      }
    'present':
      {
        Augeas <| title == "authorizationEntry/${title}/rm" |>

        augeas { "authorizationEntry/${title}/add" :
          lens    => 'Xml.lns',
          incl    => '/etc/activemq/activemq.xml',
          context => '/files/etc/activemq/activemq.xml/beans/broker/plugins/authorizationPlugin/map/authorizationMap',
          changes => [
            "set authorizationEntries/authorizationEntry[last()+1]/#attribute/${destination_real} ${destination_content}",
            "set authorizationEntries/authorizationEntry[last()]/#attribute/write ${write}",
            "set authorizationEntries/authorizationEntry[last()]/#attribute/read ${read}",
            "set authorizationEntries/authorizationEntry[last()]/#attribute/admin ${admin}",
          ],
          onlyif  => "match authorizationEntries/authorizationEntry[.][#attribute/${destination_real} =\"${destination_content}\" and #attribute/write = \"${write}\" and #attribute/read = \"${read}\" and #attribute/admin = \"${admin}\"] size == 0",
          require => [ Augeas["authorizationEntry/${title}/rm"], Class['mcollective::middleware::config'] ],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "authorizationEntry/${title}/rm" :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans/broker/plugins/authorizationPlugin/map/authorizationMap',
    changes => [
      "rm authorizationEntries/authorizationEntry[.][#attribute/${destination_real} = \"${destination_content}\"]",
    ],
    onlyif  => "match authorizationEntries/authorizationEntry[.][#attribute/${destination_real} =\"${destination_content}\" and #attribute/write = \"${write}\" and #attribute/read = \"${read}\" and #attribute/admin = \"${admin}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
