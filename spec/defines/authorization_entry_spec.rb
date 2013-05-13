#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware::config::authorization_entry' do

  context 'with faulty parameters' do
    let (:title) { 'fake_entry' }

    context 'with ensure => foo' do
      let (:params) { { :destination => 'queue', :destination_content => 'baz', :write => 'admin', :read => 'admin', :admin => 'admin', :ensure => 'foo' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter ensure must be present or absent/
      )}
    end

    context 'with destination => foo' do
      let (:params) { { :destination => 'foo', :destination_content => 'baz', :write => 'admin', :read => 'admin', :admin => 'admin' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter destination must be queue or topic/
      )}
    end

    context 'without destination_content parameter' do
      let (:params) { { :destination => 'queue', :write => 'admin', :read => 'admin', :admin => 'admin' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters destination, destination_content, write, read and admin must be defined/
      )}
    end

    context 'without write parameter' do
      let (:params) { { :destination => 'queue', :destination_content => 'baz', :read => 'admin', :admin => 'admin' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters destination, destination_content, write, read and admin must be defined/
      )}
    end
  end

  context 'with parameters' do
    let (:title) { 'fake_entry' }
    context 'with username => foo, password => bar and groups => admin' do
      let (:params) { { :destination => 'queue', :destination_content => 'baz', :read => 'admin', :write => 'admin', :admin => 'admin' } }

      it { should contain_augeas('authorizationEntry/fake_entry/rm') }
      it { should contain_augeas('authorizationEntry/fake_entry/add') }
    end

    context 'with username => foo, password => bar, groups => admin and ensure => absent' do
      let (:params) { { :destination => 'queue', :destination_content => 'baz', :read => 'admin', :write => 'admin', :admin => 'admin', :ensure => 'absent' } }

      it { should contain_augeas('authorizationEntry/fake_entry/rm') }
    end
  end

end
