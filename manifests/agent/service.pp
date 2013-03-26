class mcollective::agent::service {

  service { 'mcollective':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true
  }

}
