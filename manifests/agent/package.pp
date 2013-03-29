class mcollective::agent::package($mcollective_version=undef, $rubygem_stomp_version=undef) {

  case $::operatingsystemrelease {
    /^5./: {
      if ! $mcollective_version {
        $mcollective_version_real = 'latest'
      } else {
        $mcollective_version_real = "${mcollective_version}.el5"
      }
      if ! $rubygem_stomp_version {
        $rubygem_stomp_version_real = 'latest'
      } else {
        $rubygem_stomp_version_real = "${rubygem_stomp_version}.el5"
      }
    }

    /^6./: {
      if ! $mcollective_version {
        $mcollective_version_real = 'latest'
      } else {
        $mcollective_version_real = "${mcollective_version}.el6"
      }
      if ! $rubygem_stomp_version {
        $rubygem_stomp_version_real = 'latest'
      } else {
        $rubygem_stomp_version_real = "${rubygem_stomp_version}.el6"
      }
    }

    default: { notice("operatingsystemrelease ${::operatingsystemrelease} is not supported") }
  }

  package { 'mcollective':
    ensure => $mcollective_version_real,
  }

  package { 'mcollective-common':
    ensure => $mcollective_version_real,
  }

  package { 'mcollective-facter-facts':
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
