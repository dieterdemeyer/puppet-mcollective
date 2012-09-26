class mcollective::client($plugin_stomp_host1, $plugin_stomp_user1, $plugin_stomp_password1, $plugin_stomp_host2, $plugin_stomp_user2, $plugin_stomp_password2) {

  package { 'mcollective-client':
    ensure => '2.2.0',
  }

  package { 'mcollective-common':
    ensure => '2.2.0',
  }

  package { 'rubygem-stomp':
    ensure => '1.2.2',
  }

  package { 'cegeka-mcollective-client-plugins':
    ensure => latest,
  }

  file { '/etc/mcollective/client.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/client.cfg.erb"),
    require => [ Package['mcollective-client'], Package['mcollective-common'], Package['rubygem-stomp'], Package['cegeka-mcollective-server-plugins'] ],
  }

}
