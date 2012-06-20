class mcollective::client($plugin_stomp_host1, $plugin_stomp_user1, $plugin_stomp_password1, $plugin_stomp_host2, $plugin_stomp_user2, $plugin_stomp_password2) {

  package { ['mcollective-client', 'mcollective-common', 'rubygem-stomp']:
    ensure => present,
  }

  package { 'cegeka-mcollective-client-plugins':
    ensure => present,
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
