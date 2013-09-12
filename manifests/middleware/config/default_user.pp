#
# This user is used by for example the web console (http://<broker>:8161) to access the queues.
# 
# Specify a user that is defined in the broker config file activemq.xml (authenticationUser)
#
define mcollective::middleware::config::default_user($username='system', $password='manager') {

  file { "/etc/activemq/credentials.properties" :
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/middleware/credentials.properties.erb"),
  }

}
