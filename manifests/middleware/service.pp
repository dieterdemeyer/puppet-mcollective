class mcollective::middleware::service {

  service { 'activemq':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Class['mcollective::middleware::package']
  }

}
