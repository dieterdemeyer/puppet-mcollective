class mcollective::agent($mcollective_version=undef, $broker_host=undef, $broker_port=undef, $broker_user=undef, $broker_password=undef, $log_level='warn') {

  if ! $broker_host {
    fail('Class[Mcollective::Agent]: parameter broker_host must be provided')
  }

  if ! $broker_port {
    fail('Class[Mcollective::Agent]: parameter broker_port must be provided')
  }

  if ! $broker_user {
    fail('Class[Mcollective::Agent]: parameter broker_user must be provided')
  }

  if ! $broker_password {
    fail('Class[Mcollective::Agent]: parameter broker_password must be provided')
  }

  include mcollective::agent::service

  class { 'mcollective::agent::package':
    mcollective_version   => $mcollective_version
  }

  class { 'mcollective::agent::config':
    broker_host     => $broker_host,
    broker_port     => $broker_port,
    broker_user     => $broker_user,
    broker_password => $broker_password,
    log_level       => $log_level
  }

  Class['mcollective::agent::package'] -> Class['mcollective::agent::config'] ~> Class['mcollective::agent::service']

}
