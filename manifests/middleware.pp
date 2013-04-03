class mcollective::middleware($type=undef) {

  if $type in ['noc', 'customer'] {
    $type_real = $type
  } else {
    fail("Mcollective::Middleware: parameter type must be noc or customer")
  }

  include mcollective::middleware::package
  include mcollective::middleware::service

  class { 'mcollective::middleware::config':
    type => $type_real
  }

  #Class['mcollective::middleware::package'] -> Class['mcollective::middleware::config'] ~> Class['mcollective::middleware::service']
  Class['mcollective::middleware::package'] <- Class['mcollective::middleware::config'] ~> Class['mcollective::middleware::service']

}
