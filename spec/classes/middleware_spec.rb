#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware' do

  context 'with faulty parameters' do
    context 'with type => foo' do
      let (:params) { { :type => 'foo'} }

      it { expect { subject }.to raise_error(
        Puppet::Error, /parameter type must be noc or customer/
      )}
    end
  end

  context 'with parameters' do
    context 'with type => noc' do
      let (:params) { { :type => 'noc'} }

      it { should contain_class 'mcollective::middleware::package' }
      it { should contain_class 'mcollective::middleware::service' }

      it { should contain_class('mcollective::middleware::config').with_type('noc')}

      it { should contain_class('mcollective::middleware::config').with_before('Class[Mcollective::Middleware::Package]') }
      it { should contain_class('mcollective::middleware::package').with_notify('Class[Mcollective::Middleware::Service]') }

    end

  end

end
