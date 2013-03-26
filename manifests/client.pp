class mcollective::client($mcollective_version,
                          $rubygem_stomp_version,
                          $plugin_stomp_host1,
                          $plugin_stomp_user1,
                          $plugin_stomp_password1,
                          $plugin_stomp_host2,
                          $plugin_stomp_user2,
                          $plugin_stomp_password2) {

  class { 'mcollective::client::package':
    mcollective_version   => $mcollective_version,
    rubygem_stomp_version => $rubygem_stomp_version
  }

  class { 'mcollective::client::config':
    plugin_stomp_host1     => $plugin_stomp_host1,
    plugin_stomp_user1     => $plugin_stomp_user1,
    plugin_stomp_password1 => $plugin_stomp_password1,
    plugin_stomp_host2     => $plugin_stomp_host2,
    plugin_stomp_user2     => $plugin_stomp_user2,
    plugin_stomp_password2 => $plugin_stomp_password2
  }

  Class['mcollective::client::package'] -> Class['mcollective::client::config']

}
