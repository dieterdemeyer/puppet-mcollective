class mcollective::client($mcollective_version=undef, $broker_pool_config=[]) {

  class { 'mcollective::client::package':
    mcollective_version   => $mcollective_version
  }

  class { 'mcollective::client::config':
    broker_pool_config => $broker_pool_config
  }

  Class['mcollective::client::package'] -> Class['mcollective::client::config']

}
