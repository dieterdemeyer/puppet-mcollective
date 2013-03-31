class mcollective::client::package($mcollective_version=undef, $rubygem_stomp_version=undef) {

  include mcollective::common::package

  case $::operatingsystemrelease {
    /^5./: {
      $mcollective_version_real = "${mcollective_version}.el5"
      $rubygem_stomp_version_real = "${rubygem_stomp_version}.el5"
    }

    /^6./: {
      $mcollective_version_real = "${mcollective_version}.el6"
      $rubygem_stomp_version_real = "${rubygem_stomp_version}.el6"
    }

    default: { notice("operatingsystemrelease ${::operatingsystemrelease} is not supported") }
  }

  package { ['mcollective-common', 'mcollective-client']:
    ensure => $mcollective_version_real,
  }

  package { 'mcollective-facter-facts':
    ensure => latest,
  }

}
