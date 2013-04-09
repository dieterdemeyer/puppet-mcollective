define mcollective::plugin($ensure = 'present', $type = undef) {

  case $ensure {
    'latest', 'present', 'absent': { $ensure_real = $ensure }
    default: { fail('Class[mcollective::plugin]: parameter ensure must be latest, present or absent') }
  }


  if ! ($type in ['client', 'agent']) {
    fail('Class[mcollective::plugin]: parameter type must be client or agent')
  }

  $common_package = "mcollective-${title}-common"
  $client_package = "mcollective-${title}-client"
  $agent_package = "mcollective-${title}-agent"

  package { $common_package :
    ensure  => $ensure,
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
    default: { notice("Plugin type ${type} is not supported") }
  }

}
