class mcollective::client::config($plugin_stomp_broker_config=[]) {

  file { '/etc/mcollective/client.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/client/client.cfg.erb")
  }

}
