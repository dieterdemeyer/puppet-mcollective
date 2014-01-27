class mcollective::middleware::package {

  include mcollective::common::package

  package { ['activemq', 'activemq-info-provider']:
    ensure => '5.5.0-1.el6',
  }

  package { ['tanukiwrapper', 'rubygems']:
    ensure => present
  }

}
