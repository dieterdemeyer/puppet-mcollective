class mcollective::agent::config($plugin_stomp_host, $plugin_stomp_user, $plugin_stomp_password) {

  file { '/etc/mcollective/server.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/agent/server.cfg.erb"),
    notify  => Class['mcollective::agent::service']
  }

}
