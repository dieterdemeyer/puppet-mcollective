class mcollective::client::config($plugin_stomp_host1,
                                  $plugin_stomp_user1,
                                  $plugin_stomp_password1,
                                  $plugin_stomp_host2,
                                  $plugin_stomp_user2,
                                  $plugin_stomp_password2) {

  file { '/etc/mcollective/client.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/client.cfg.erb")
  }

}
