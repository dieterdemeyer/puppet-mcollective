class mcollective::common::package {

  package { 'stomp':
    ensure   => '1.3.2',
    provider => gem
  }

}
