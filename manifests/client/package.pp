class mcollective::client::package($mcollective_version, $rubygem_stomp_version) {

  package { ['mcollective-common', 'mcollective-client']:
    ensure => $mcollective_version,
  }

  package { 'rubygem-stomp':
    ensure => $rubygem_stomp_version,
  }

}
