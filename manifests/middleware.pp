class mcollective::middleware {

  include mcollective::middleware::package
  include mcollective::middleware::service

  Class['mcollective::middleware::package'] -> Class['mcollective::middleware::config'] ~> Class['mcollective::middleware::service']

}
