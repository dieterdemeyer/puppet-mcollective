class mcollective::middleware::package {

  package { ['tanukiwrapper', 'activemq', 'activemq-info-provider', 'rubygems', 'rubygem-stomp']:
    ensure => installed
  }

}
