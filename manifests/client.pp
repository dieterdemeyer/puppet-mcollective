class mcollective::client($mcollective_version,
                          $rubygem_stomp_version,
                          $plugin_stomp_broker_config) {

  class { 'mcollective::client::package':
    mcollective_version   => $mcollective_version,
    rubygem_stomp_version => $rubygem_stomp_version
  }

  class { 'mcollective::client::config':
    plugin_stomp_broker_config => $plugin_stomp_broker_config
  }

  Class['mcollective::client::package'] -> Class['mcollective::client::config']

}
