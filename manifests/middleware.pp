class mcollective::middleware($type=undef, $ssl=false, $activemq_version='5.8.0-3') {

  if $type in ['noc', 'customer'] {
    $type_real = $type
  } else {
    fail('Mcollective::Middleware: parameter type must be noc or customer')
  }

  class { 'mcollective::middleware::package':
    activemq_version => $activemq_version
  }

  include mcollective::middleware::service

  class { 'mcollective::middleware::config':
    type => $type_real,
    ssl  => $ssl,
  }

  Class['mcollective::middleware::config'] -> Class['mcollective::middleware::package'] ~> Class['mcollective::middleware::service']

}
