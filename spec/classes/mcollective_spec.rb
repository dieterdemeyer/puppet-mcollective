#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective' do
  it { should contain_class 'mcollective' }
end
