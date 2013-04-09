#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::plugin' do

  context 'with faulty parameters' do
    context 'with ensure => foo' do
      let (:title) { 'shell' }
      let (:params) { { :ensure => 'foo' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter ensure must be latest, present or absent/
      )}
    end

    context 'with type => bar' do
      let (:title) { 'shell' }
      let (:params) { { :type => 'bar' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter type must be client or agent/
      )}
    end
  end

  context 'with parameters' do
    context 'with type => client' do
      let (:title) { 'shell' }
      let (:params) { { :type => 'client' } }

      it { should contain_package('mcollective-shell-common') }

      it { should contain_package('mcollective-shell-client').with_ensure('present') }
    end

    context 'with type => agent' do
      let (:title) { 'shell' }
      let (:params) { { :type => 'agent' } }

      it { should contain_package('mcollective-shell-common') }

      it { should contain_package('mcollective-shell-agent').with_ensure('present') }
    end
  end

end
