class mcollective::agent::package($mcollective_version, $rubygem_stomp_version) {

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

  package { 'mcollective':
    ensure => $mcollective_version_real,
  }

  package { 'mcollective-common':
    ensure => $mcollective_version_real,
  }

  package { 'rubygem-stomp':
    ensure => $rubygem_stomp_version_real,
  }

  package { 'sys-proctable':
    ensure   => installed,
    provider => gem
  }

}
