class { 'mcollective::agent':
  mcollective_version   => '2.2.3-1',
  broker_host     => 'server.example.com',
  broker_port     => '61613'
  broker_user     => 'username',
  broker_password => 'password'
}
