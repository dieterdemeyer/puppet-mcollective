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
        Augeas <| title == "plugins/simpleAuthenticationPlugin/users/authenticationUser/${username}/rm" |>
      }
    'present':
      {
        Augeas <| title == "plugins/simpleAuthenticationPlugin/users/authenticationUser/${username}/rm" |>

        augeas { "plugins/simpleAuthenticationPlugin/users/authenticationUser/${username}/add" :
          lens    => 'Xml.lns',
          incl    => '/etc/activemq/activemq.xml',
          context => '/files/etc/activemq/activemq.xml',
          changes => [
            "set beans/broker/plugins/simpleAuthenticationPlugin/users/authenticationUser[last()+1]/#attribute/username ${username}",
            "set beans/broker/plugins/simpleAuthenticationPlugin/users/authenticationUser[last()]/#attribute/password ${password}",
            "set beans/broker/plugins/simpleAuthenticationPlugin/users/authenticationUser[last()]/#attribute/groups ${groups}",
          ],
          onlyif  => "match beans/broker/plugins/simpleAuthenticationPlugin/users/authenticationUser[#attribute/username[. = \"${username}\"] and #attribute/password[. = \"${password}\"] and #attribute/groups[. = \"${groups}\"]] size == 0",
          require => [ Augeas["plugins/simpleAuthenticationPlugin/users/authenticationUser/${username}/rm"], Class['mcollective::middleware::config'] ],
          notify  => Class['mcollective::middleware::service']
        }
      }
    default: { notice('The given ensure parameter is not supported') }
  }

  @augeas { "plugins/simpleAuthenticationPlugin/users/authenticationUser/${username}/rm" :
    lens    => 'Xml.lns',
    incl    => '/etc/activemq/activemq.xml',
    context => '/files/etc/activemq/activemq.xml',
    changes => [
      "rm beans/broker/plugins/simpleAuthenticationPlugin/users/authenticationUser[.][#attribute/username = \"${username}\"]",
    ],
    onlyif  => "match beans/broker/plugins/simpleAuthenticationPlugin/users/authenticationUser[#attribute/username[. = \"${username}\"] and #attribute/password[. = \"${password}\"] and #attribute/groups[. = \"${groups}\"]] size == 0",
    require => Class['mcollective::middleware::config'],
    notify  => Class['mcollective::middleware::service']
  }

}
