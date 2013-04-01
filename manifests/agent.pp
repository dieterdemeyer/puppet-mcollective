class mcollective::agent($mcollective_version=undef, $broker_host=undef, $broker_port='61613', $broker_user=undef, $broker_password=undef) {

  include mcollective::agent::service

  class { 'mcollective::agent::package':
    mcollective_version   => $mcollective_version
  }

  class { 'mcollective::agent::config':
    broker_host     => $broker_host,
    broker_port     => $broker_port,
    broker_user     => $broker_user,
    broker_password => $broker_password
  }

  Class['mcollective::agent::package'] -> Class['mcollective::agent::config'] ~> Class['mcollective::agent::service']

}
