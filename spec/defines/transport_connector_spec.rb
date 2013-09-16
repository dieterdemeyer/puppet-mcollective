#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware::config::transport_connector' do

  context 'with faulty parameters' do
    context 'with ensure => foo' do
      let (:title) { 'openwire' }
      let (:params) { { :type => 'openwire', :port => '61616', :ensure => 'foo' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter ensure must be present or absent/
      )}
    end

    context 'without type parameter' do
      let (:title) { 'openwire' }
      let (:params) { { :port => '61616' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter 'type' must be provided/
      )}
    end

    context 'without port parameter' do
      let (:title) { 'openwire' }
      let (:params) { { :type => 'openwire' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter 'port' must be provided/
      )}
    end

    context 'wrong type parameter' do
      let (:title) { 'stomp' }
      let (:params) { { :type => 'stamp', :port => '61614' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter 'type' has to be 'openwire' or 'stomp'/
      )}
    end
end

  context 'with parameters' do
    context 'with type => openwire and port => 61616' do
      let (:title) { 'openwire' }
      let (:params) { { :type=> 'openwire', :port => '61616' } }

      it { should contain_augeas('transportConnectors/transportConnector/openwire/rm') }
      it { should contain_augeas('transportConnectors/transportConnector/openwire/add') }
    end

    context 'with type => openwire and port => 61616 ensure => absent' do
      let (:title) { 'openwire' }
      let (:params) { { :type => 'openwire', :port => '61616', :ensure => 'absent' } }

      it { should contain_augeas('transportConnectors/transportConnector/openwire/rm') }
    end
  end

end
