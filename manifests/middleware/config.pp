class mcollective::middleware::config($type=undef) {

  file { '/etc/activemq':
    ensure => directory
  }

  file { '/etc/activemq/activemq.xml':
    ensure  => file,
    mode    => '0755',
    content => template("${module_name}/middleware/${type}/activemq.xml.erb"),
    replace => false,
    require => File['/etc/activemq']
  }

  #  augeas { 'set activemq-conf-usededicatedtaskrunner to false':
  #  context   => '/files/usr/share/activemq/conf/activemq-wrapper.conf',
  #  changes   => 'set wrapper.java.additional.4 -Dorg.apache.activemq.UseDedicatedTaskRunner=false',
  #  load_path => "${settings::vardir}/lib/augeas/lenses",
  #}

  #augeas { 'set activemq-conf-maxmemory to 512MB':
  #  context   => '/files/usr/share/activemq/conf/activemq-wrapper.conf',
  #  changes   => 'set wrapper.java.maxmemory 512',
  #  load_path => "${settings::vardir}/lib/augeas/lenses",
  #}

}
