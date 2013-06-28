define mcollective::plugin($ensure = 'present', $type = undef) {

  case $ensure {
    'latest', 'present', 'absent': { $ensure_real = $ensure }
    default: { fail('Class[mcollective::plugin]: parameter ensure must be latest, present or absent') }
  }


  if ! ($type in ['client', 'agent', 'both']) {
    fail('Class[mcollective::plugin]: parameter type must be client or agent or both')
  }

  $common_package = "mcollective-${title}-common"
  $client_package = "mcollective-${title}-client"
  $agent_package = "mcollective-${title}-agent"

  if ($type in ['client', 'agent']) {
    package { $common_package :
      ensure  => $ensure,
      require => Class["mcollective::${type}::package"]
    }
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
    'both': {
      package { $common_package :
        ensure  => $ensure,
        require => Class["mcollective::client::package"]
      }

      package { $client_package :
        ensure  => $ensure,
        require => Class["mcollective::client::package"]
      }

      package { $agent_package :
        ensure  => $ensure,
        require => Class["mcollective::agent::package"],
        notify  => Class["mcollective::agent::service"]
      }
    }
    default: { notice("Plugin type ${type} is not supported") }
  }

}
