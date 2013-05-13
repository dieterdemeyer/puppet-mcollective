#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware::config::authentication_user' do

  context 'with faulty parameters' do
    let (:title) { 'fake_user' }

    context 'with ensure => foo' do
      let (:params) { { :username => 'bar', :password => 'baz', :groups => 'admin', :ensure => 'foo' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter ensure must be present or absent/
      )}
    end

    context 'without username parameter' do
      let (:params) { { :password => 'baz', :groups => 'admin' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters username, password and groups must be defined/
      )}
    end

    context 'without password parameter' do
      let (:params) { { :username => 'bar', :groups => 'admin' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters username, password and groups must be defined/
      )}
    end

    context 'without groups parameter' do
      let (:params) { { :username => 'bar', :password => 'baz' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters username, password and groups must be defined/
      )}
    end
  end

  context 'with parameters' do
    let (:title) { 'fake_user' }
    context 'with username => foo, password => bar and groups => admin' do
      let (:params) { { :username => 'foo', :password => 'bar', :groups => 'admin' } }

      it { should contain_augeas('authenticationUser/foo/rm') }
      it { should contain_augeas('authenticationUser/foo/add') }
    end

    context 'with username => foo, password => bar, groups => admin and ensure => absent' do
      let (:params) { { :username => 'foo', :password => 'bar', :groups => 'admin', :ensure => 'absent' } }

      it { should contain_augeas('authenticationUser/foo/rm') }
    end
  end

end
