class mcollective::client::config($broker_pool_config=[], $message_ssl = false) {

  file { '/etc/mcollective/client.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/client/client.cfg.erb")
  }

  if ($message_ssl) {

    file {'/etc/mcollective/ssl/private_keys' :
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
    }

    file {'/etc/mcollective/ssl/public_keys' :
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
    }

    file {'/etc/mcollective/ssl/private_keys/mcoclient-priv.pem' :
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => "puppet:///modules/${module_name}/ssl/mcoclient-priv.pem",
    }

    file {'/etc/mcollective/ssl/public_keys/mcoclient-pub.pem' :
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => "puppet:///modules/${module_name}/ssl/mcoclient-pub.pem",
    }

    # Agent's public key:
    file {'/etc/mcollective/ssl/public_keys/mcoserver-pub.pem' :
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => "puppet:///modules/${module_name}/ssl/mcoserver-pub.pem",
    }

  }
}
