class mcollective::client($mcollective_version=undef, $broker_pool_config=[], $message_ssl=false) {

  class { 'mcollective::client::package':
    mcollective_version => $mcollective_version
  }

  class { 'mcollective::client::config':
    broker_pool_config => $broker_pool_config,
    message_ssl        => $message_ssl
  }

  Class['mcollective::client::package'] -> Class['mcollective::client::config']

}
