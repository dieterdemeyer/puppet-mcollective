class mcollective::agent::package($mcollective_version=undef) {

  include mcollective::common::package

  case $::operatingsystemrelease {
    /^5./: {
      if ! $mcollective_version {
        $mcollective_version_real = 'latest'
      } else {
        $mcollective_version_real = "${mcollective_version}.el5"
      }
    }

    /^6./: {
      if ! $mcollective_version {
        $mcollective_version_real = 'latest'
      } else {
        $mcollective_version_real = "${mcollective_version}.el6"
      }
    }

    default: { notice("operatingsystemrelease ${::operatingsystemrelease} is not supported") }
  }

  package { 'mcollective':
    ensure => $mcollective_version_real,
  }

  if ! defined (Package['mcollective-common']) {
    package { 'mcollective-common':
      ensure => $mcollective_version_real
    }
  }

  if ! defined(Package['mcollective-facter-facts']) {
    package { 'mcollective-facter-facts':
      ensure => present
    }
  }

  package { 'sys-proctable':
    ensure   => installed,
    provider => gem
  }

}
