class mcollective::common::package {

  package { 'rubygem-stomp':
    ensure => present
  }

  package { 'mcollective-facter-facts':
    ensure => present
  }

}
