#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware::config::network_connector' do

  context 'with faulty parameters' do
    let (:title) { 'broker_name' }

    context 'with ensure => foo' do
      let (:params) { { :destinationhost => 'customer.broker.example.com', :port=>'61616', :username => 'bar', :password => 'baz', :ensure => 'foo' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter ensure must be present or absent/
      )}
    end

    context 'without destinationhost parameter' do
      let (:params) { { :username => 'bar', :password => 'baz' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters destinationhost, username and password must be defined/
      )}
    end

    context 'without username parameter' do
      let (:params) { { :destinationhost => 'customer.broker.example.com', :port=>'61616', :password => 'baz' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters destinationhost, username and password must be defined/
      )}
    end

    context 'without password parameter' do
      let (:params) { { :destinationhost => 'customer.broker.example.com', :port=>'61616', :username => 'bar'} }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameters destinationhost, username and password must be defined/
      )}
    end
  end

  context 'with parameters' do
    let (:title) { 'broker_to_broker' }
    context 'with destinationhost => customer.broker.example.com, username => foo, password => bar' do
      let (:params) { { :destinationhost => 'customer.broker.example.com', :username => 'foo', :password => 'bar' } }

      it { should contain_augeas('networkConnectors/networkConnector/broker_to_broker/rm') }
      it { should contain_augeas('networkConnectors/networkConnector/broker_to_broker/add') }
    end

    context 'with destinationhost => 0.0.0.0 and ensure => absent' do
      let (:params) { { :destinationhost => 'customer.broker.example.com', :username => 'foo', :password => 'bar', :ensure => 'absent' } }

      it { should contain_augeas('networkConnectors/networkConnector/broker_to_broker/rm') }
    end
  end

end
