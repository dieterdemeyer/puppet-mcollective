define mcollective::plugin($ensure = 'present', $type = undef) {

  case $ensure {
    'present', 'absent': { $ensure_real = $ensure }
    default: { fail('Class[mcollective::plugin]: parameter ensure must be present or absent') }
  }


  if ! ($type in ['client', 'agent']) {
    fail('Class[mcollective::plugin]: parameter type must be client or agent')
  }

  $common_package = "mcollective-${name}-common"
  $client_package = "mcollective-${name}-client"
  $agent_package = "mcollective-${name}-agent"

  package { $common_package :
    ensure => $ensure,
    require => Class["mcollective::${type}::package"]
  }

  case $type {
    'client': {
      package { $client_package :
        ensure  => $ensure,
        require => Class["mcollective::${type}::package"]
      }
    }
    'agent': {
      package { $agent_package :
        ensure  => $ensure,
        require => Class["mcollective::${type}::package"],
        notify  => Class["mcollective::${type}::service"]
      }
    }
  }

}
