class mcollective::middleware::package {

  include mcollective::common::package

  package { ['activemq', 'activemq-info-provider']:
    ensure => present
  }

  package { ['tanukiwrapper', 'rubygems']:
    ensure => present
  }

}
