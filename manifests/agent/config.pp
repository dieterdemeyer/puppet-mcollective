class mcollective::agent::config($broker_host=undef, $broker_port='61613', $broker_user=undef, $broker_password=undef) {

  file { '/etc/mcollective/server.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/agent/server.cfg.erb"),
    notify  => Class['mcollective::agent::service']
  }

}
