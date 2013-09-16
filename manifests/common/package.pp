class mcollective::common::package {

  package { 'rubygem-stomp':
    ensure => latest
  }

}
