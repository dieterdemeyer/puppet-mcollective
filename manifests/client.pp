class mcollective::client($mcollective_version=undef, $broker_pool_config=[], $type='cli', $log_level='warn') {

  class { 'mcollective::client::package':
    mcollective_version => $mcollective_version
  }

  class { 'mcollective::client::config':
    broker_pool_config => $broker_pool_config,
    type               => $type,
    log_level          => $log_level
  }

  Class['mcollective::client::package'] -> Class['mcollective::client::config']

}
