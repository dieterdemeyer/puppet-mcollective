#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::client' do

  context 'with default parameters' do
    it { should contain_class('mcollective::client::package').without_mcollective_version }
    it { should contain_class('mcollective::client::config').with_broker_pool_config([])}
    it { should contain_class('mcollective::client::package').with_before('Class[Mcollective::Client::Config]') }
  end

end
