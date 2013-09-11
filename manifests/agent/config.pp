class mcollective::agent::config($broker_host=undef, $broker_port=undef, $broker_user=undef, $broker_password=undef, $message_ssl = false) {

  file { '/etc/mcollective/server.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/agent/server.cfg.erb"),
    notify  => Class['mcollective::agent::service']
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

    file {'/etc/mcollective/ssl/private_keys/mcoserver-priv.pem' :
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => "puppet:///modules/${module_name}/ssl/mcoserver-priv.pem",
    }

    file {'/etc/mcollective/ssl/public_keys/mcoserver-pub.pem' :
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => "puppet:///modules/${module_name}/ssl/mcoserver-pub.pem",
    }

    # Client's public key:
    file {'/etc/mcollective/ssl/clients/mcoclient-pub.pem' :
      ensure => file,
      owner  => root,
      group  => root,
      mode   => '0644',
      source => "puppet:///modules/${module_name}/ssl/mcoclient-pub.pem",
    }

  }
}
