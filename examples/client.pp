class { 'mcollective::client':
  mcollective_version    => '2.2.3-1',
  broker_pool_config => [
    { 'host' => 'server.example.com', 'port' => '61613', 'user' => 'username', 'password' => 'password' }
  ]
}
