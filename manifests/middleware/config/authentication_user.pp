define mcollective::middleware::config::authentication_user($username, $password, $groups, $ensure='present') {

  if $ensure in [ 'present', 'absent' ] {
    $ensure_real = $ensure
  }
  else {
    fail("Mcollective::Middleware::Config::Authentication_user[${title}]: parameter ensure must be present or absent")
  }

  case $ensure_real {
    'absent':
      {
        Augeas <| title == "authenticationUser/${username}/rm" |>
      }
    'present':
      {
        Augeas <| title == "authenticationUser/${username}/rm" |>

        augeas { "authenticationUser/${username}/add" :
          lens    => 'Xml.lns',
          incl    => '/etc/activemq/activemq.xml',
          context => '/files/etc/activemq/activemq.xml/beans/broker/plugins/simpleAuthenticationPlugin',
          changes => [
            "set users/authenticationUser[last()+1]/#attribute/username ${username}",
            "set users/authenticationUser[last()]/#attribute/password ${password}",
            "set users/authenticationUser[last()]/#attribute/groups ${groups}",
          ],
          onlyif  => "match users/authenticationUser[.][#attribute/username = \"${username}\" and #attribute/password = \"${password}\" and #attribute/groups = \"${groups}\"] size == 0",
          require => [ Augeas["authenticationUser/${username}/rm"], Class['mcollective::middleware::config'] ],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "authenticationUser/${username}/rm" :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml/beans/broker/plugins/simpleAuthenticationPlugin',
    changes => [
      "rm users/authenticationUser[.][#attribute/username = \"${username}\"]",
    ],
    onlyif  => "match users/authenticationUser[.][#attribute/username = \"${username}\" and #attribute/password = \"${password}\" and #attribute/groups = \"${groups}\"] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
