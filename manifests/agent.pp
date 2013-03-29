class mcollective::agent($mcollective_version=undef, $rubygem_stomp_version=undef, $plugin_stomp_host=undef, $plugin_stomp_user=undef, $plugin_stomp_password=undef) {

  include mcollective::agent::service

  class { 'mcollective::agent::package':
    mcollective_version   => $mcollective_version,
    rubygem_stomp_version => $rubygem_stomp_version
  }

  class { 'mcollective::agent::config':
    plugin_stomp_host     => $plugin_stomp_host,
    plugin_stomp_user     => $plugin_stomp_user,
    plugin_stomp_password => $plugin_stomp_password
  }

  Class['mcollective::agent::package'] -> Class['mcollective::agent::config'] ~> Class['mcollective::agent::service']

}
