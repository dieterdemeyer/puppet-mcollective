class mcollective::middleware::package($activemq_version='5.5.0-1') {

  include mcollective::common::package

  case $::operatingsystemrelease {
    /^5./: { $osrelease = 'el5' }
    /^6./: { $osrelease = 'el6' }
    default: { notice("operatingsystemrelease ${::operatingsystemrelease} is not supported") }
  }

  package { ['activemq', 'activemq-info-provider']:
    ensure => "${activemq_version}.${osrelease}",
  }

  package { ['tanukiwrapper', 'rubygems']:
    ensure => present
  }

}
