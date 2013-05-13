#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware::config::transport_connector' do

  context 'with faulty parameters' do
    context 'with ensure => foo' do
      let (:title) { 'openwire' }
      let (:params) { { :uri => 'tcp://0.0.0.0:61616', :ensure => 'foo' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter ensure must be present or absent/
      )}
    end

    context 'without uri parameter' do
      let (:title) { 'openwire' }
      let (:params) { { } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter uri must be provided/
      )}
    end
  end

  context 'with parameters' do
    context 'with uri => tcp://0.0.0.0:61616' do
      let (:title) { 'openwire' }
      let (:params) { { :uri => 'tcp://0.0.0.0:61616' } }

      it { should contain_augeas('transportConnectors/transportConnector/openwire/rm') }
      it { should contain_augeas('transportConnectors/transportConnector/openwire/add') }
    end

    context 'with uri => tcp://0.0.0.0:61616 and ensure => absent' do
      let (:title) { 'openwire' }
      let (:params) { { :uri => 'tcp://0.0.0.0:61616', :ensure => 'absent' } }

      it { should contain_augeas('transportConnectors/transportConnector/openwire/rm') }
    end
  end

end
