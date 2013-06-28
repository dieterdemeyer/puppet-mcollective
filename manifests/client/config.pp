class mcollective::client::config($broker_pool_config=[], $type='cli', $log_level='warn') {

  case $type {
    'cli': {
      file { '/etc/mcollective/client.cfg' :
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template("${module_name}/client/client.cfg.erb")
      }
    }
    'mcomaster': {
      file { '/etc/mcollective/client.cfg' :
        ensure  => file,
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template("${module_name}/mcomaster/client.cfg.erb")
      }
    }
  }

}
