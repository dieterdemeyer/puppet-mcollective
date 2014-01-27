class mcollective::middleware::package {

  include mcollective::common::package

  if ($operatingsystemmajrelease == '6') {
    $osrelease = 'el6'
  } else {
    $osrelease = 'el5'
  }

  package { ['activemq', 'activemq-info-provider']:
    ensure => "5.5.0-1.${osrelease}",
  }

  package { ['tanukiwrapper', 'rubygems']:
    ensure => present
  }

}
