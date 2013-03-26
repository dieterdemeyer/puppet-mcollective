class mcollective::config::agent {

  file { '/etc/mcollective/server.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/server.cfg.erb")
  }

}
