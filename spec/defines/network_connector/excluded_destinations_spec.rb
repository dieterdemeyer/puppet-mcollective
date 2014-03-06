#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::middleware::config::network_connector::excluded_destinations' do
  context 'with title broker1-topics' do
    let (:title) { 'broker1-topics' }

    context 'with ensure => absent' do
      let (:params) { {
        :ensure => 'absent'
      } }

      it { should contain_augeas('networkConnector/broker1-topics/excludedDestinations').with(
        :lens    => 'Xml.lns',
        :incl    => '/etc/activemq/activemq.xml',
        :context => '/files/etc/activemq/activemq.xml/beans/broker/networkConnectors/networkConnector[#attribute/name = "broker1-topics"]',
        :changes => [
          'rm excludedDestinations'
        ]
      )}
    end

    context 'with default parameters' do
      let (:params) { { } }

      it { should contain_mcollective__middleware__config__network_connector__excluded_destinations('broker1-topics').with(
        :ensure => 'present',
        :queue  => [],
        :topic  => []
      )}

      it { should contain_augeas('networkConnector/broker1-topics/excludedDestinations/queue').with(
        :lens    => 'Xml.lns',
        :incl    => '/etc/activemq/activemq.xml',
        :context => '/files/etc/activemq/activemq.xml/beans/broker/networkConnectors/networkConnector[#attribute/name = "broker1-topics"]',
        :changes => [
          'rm excludedDestinations/queue'
        ]
      )}

      it { should contain_augeas('networkConnector/broker1-topics/excludedDestinations/topic').with(
        :lens    => 'Xml.lns',
        :incl    => '/etc/activemq/activemq.xml',
        :context => '/files/etc/activemq/activemq.xml/beans/broker/networkConnectors/networkConnector[#attribute/name = "broker1-topics"]',
        :changes => [
          'rm excludedDestinations/topic'
        ]
      )}
    end

    context 'with queue => ">" and topic => "test.foo"' do
      let (:params) { {
        :queue => '>',
        :topic => 'test.foo'
      } }

      it { should contain_augeas('networkConnector/broker1-topics/excludedDestinations/queue/>').with(
        :lens    => 'Xml.lns',
        :incl    => '/etc/activemq/activemq.xml',
        :context => '/files/etc/activemq/activemq.xml/beans/broker/networkConnectors/networkConnector[#attribute/name = "broker1-topics"]',
        :onlyif  => 'match excludedDestinations/queue/#attribute/physicalName[. = ">"] size == 0',
        :changes => [
          'set excludedDestinations/queue[last()+1]/#attribute/physicalName ">"'
        ]
      )}

      it { should contain_augeas('networkConnector/broker1-topics/excludedDestinations/topic/test.foo').with(
        :lens    => 'Xml.lns',
        :incl    => '/etc/activemq/activemq.xml',
        :context => '/files/etc/activemq/activemq.xml/beans/broker/networkConnectors/networkConnector[#attribute/name = "broker1-topics"]',
        :onlyif  => 'match excludedDestinations/topic/#attribute/physicalName[. = "test.foo"] size == 0',
        :changes => [
          'set excludedDestinations/topic[last()+1]/#attribute/physicalName "test.foo"'
        ]
      )}
    end
  end
end
