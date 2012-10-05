class mcollective::server($plugin_stomp_host, $plugin_stomp_user, $plugin_stomp_password) {

  package { 'mcollective':
    ensure => '2.2.0-1',
  }

  package { 'mcollective-common':
    ensure => '2.2.0-1',
  }

  package { 'rubygem-stomp':
    ensure => '1.2.2-1',
  }

  package { 'sys-proctable':
    ensure   => present,
    provider => gem,
    notify   => Service['mcollective'],
  }

  package { 'cegeka-mcollective-server-plugins':
    ensure => latest,
    notify => Service['mcollective'],
  }

  file { '/etc/mcollective/server.cfg' :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template("${module_name}/server.cfg.erb"),
    notify  => Service['mcollective'],
    require => [ Package['mcollective'], Package['mcollective-common'], Package['rubygem-stomp'], Package['sys-proctable'], Package['cegeka-mcollective-server-plugins'] ],
  }

  service { 'mcollective':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['mcollective'],
  }

}
