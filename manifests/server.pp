class mcollective::server($plugin_stomp_host, $plugin_stomp_user, $plugin_stomp_password) {

  case $::operatingsystemrelease {
    /^5./: {
      $mcollective_version = '2.2.0-1.el5'
      $mcollective_common_version = '2.2.0-1.el5'
      $rubygem_stomp_version = '1.2.2-1.el5'
    }

    /^6./: {
      $mcollective_version = '2.2.0-1.el6'
      $mcollective_common_version = '2.2.0-1.el6'
      $rubygem_stomp_version = '1.2.2-1.el6'
    }

    default: { notice("operatingsystemrelease ${::operatingsystemrelease} is not supported") }
  }

  package { 'mcollective':
    ensure => $mcollective_version,
  }

  package { 'mcollective-common':
    ensure => $mcollective_common_version,
  }

  package { 'rubygem-stomp':
    ensure => $rubygem_stomp_version,
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
