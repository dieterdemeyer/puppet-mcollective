#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::agent' do

  context 'with faulty input' do
    context 'without broker_host' do
      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter broker_host must be provided/
      )}
    end

    context 'without broker_port' do
      let (:params) { { :broker_host => 'foo.example.com', :broker_user => 'bar', :broker_password => 'baz' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter broker_port must be provided/
      )}
    end

    context 'without broker_user' do
      let (:params) { { :broker_host => 'foo.example.com', :broker_port => '61613', :broker_password => 'baz' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter broker_user must be provided/
      )}
    end

    context 'without broker_password' do
      let (:params) { { :broker_host => 'foo.example.com', :broker_port => '61613', :broker_user => 'bar' } }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter broker_password must be provided/
      )}
    end
  end

  context 'with parameters' do
    context 'broker_host => foo.example.com, broker_port => 61613, broker_user => bar, broker_password => baz' do

      let (:params) { { :broker_host => 'foo.example.com', :broker_port => '61613', :broker_user => 'bar', :broker_password => 'baz' } }

      it { should contain_class('mcollective::agent::package').without_mcollective_version }

      it { should contain_class('mcollective::agent::config').with_broker_host('foo.example.com')}
      it { should contain_class('mcollective::agent::config').with_broker_port('61613')}
      it { should contain_class('mcollective::agent::config').with_broker_user('bar')}
      it { should contain_class('mcollective::agent::config').with_broker_password('baz')}

      it { should contain_class('mcollective::agent::package').with_before('Class[Mcollective::Agent::Config]') }
      it { should contain_class('mcollective::agent::config').with_notify('Class[Mcollective::Agent::Service]') }
    end
  end

end
