class mcollective::middleware::config($type=undef) {

  file { '/etc/activemq':
    ensure => directory
  }

  file { '/etc/activemq/activemq.xml':
    ensure  => file,
    mode    => '755',
    content => template("${module_name}/middleware/${type}/activemq.xml.erb"),
    replace => false,
    require => File['/etc/activemq']
  }

}
