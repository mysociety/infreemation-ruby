# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Infreemation do
  it 'has a version number' do
    expect(Infreemation::VERSION).not_to be nil
  end

  describe 'url' do
    it 'must be assignable' do
      Infreemation.url = 'url'
      expect(Infreemation.url).to eq 'url'
    end

    it 'must raise an exception when not set' do
      if Infreemation.instance_variable_defined?(:@url)
        Infreemation.send(:remove_instance_variable, :@url)
      end
      expect { Infreemation.url }.to raise_error(ConfigurationError)
    end

    it 'must raise an exception when set to nil' do
      Infreemation.url = nil
      expect { Infreemation.url }.to raise_error(ConfigurationError)
    end
  end

  describe 'api key' do
    it 'must be assignable' do
      Infreemation.api_key = 'new_key'
      expect(Infreemation.api_key).to eq 'new_key'
    end

    it 'must raise an exception when not set' do
      if Infreemation.instance_variable_defined?(:@api_key)
        Infreemation.send(:remove_instance_variable, :@api_key)
      end
      expect { Infreemation.api_key }.to raise_error(ConfigurationError)
    end

    it 'must raise an exception when set to nil' do
      Infreemation.api_key = nil
      expect { Infreemation.api_key }.to raise_error(ConfigurationError)
    end
  end

  describe 'username' do
    it 'must be assignable' do
      Infreemation.username = 'username'
      expect(Infreemation.username).to eq 'username'
    end

    it 'must raise an exception when not set' do
      if Infreemation.instance_variable_defined?(:@username)
        Infreemation.send(:remove_instance_variable, :@username)
      end
      expect { Infreemation.username }.to raise_error(ConfigurationError)
    end

    it 'must raise an exception when set to nil' do
      Infreemation.username = nil
      expect { Infreemation.username }.to raise_error(ConfigurationError)
    end
  end
end
