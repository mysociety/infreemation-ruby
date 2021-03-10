# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Infreemation do
  it 'has a version number' do
    expect(Infreemation::VERSION).not_to be nil
  end

  describe 'url' do
    it 'must be assignable' do
      described_class.url = 'url'
      expect(described_class.url).to eq 'url'
    end

    it 'must raise an exception when not set' do
      if described_class.instance_variable_defined?(:@url)
        described_class.send(:remove_instance_variable, :@url)
      end
      expect { described_class.url }.to raise_error(ConfigurationError)
    end

    it 'must raise an exception when set to nil' do
      described_class.url = nil
      expect { described_class.url }.to raise_error(ConfigurationError)
    end
  end

  describe 'api key' do
    it 'must be assignable' do
      described_class.api_key = 'new_key'
      expect(described_class.api_key).to eq 'new_key'
    end

    it 'must raise an exception when not set' do
      if described_class.instance_variable_defined?(:@api_key)
        described_class.send(:remove_instance_variable, :@api_key)
      end
      expect { described_class.api_key }.to raise_error(ConfigurationError)
    end

    it 'must raise an exception when set to nil' do
      described_class.api_key = nil
      expect { described_class.api_key }.to raise_error(ConfigurationError)
    end
  end

  describe 'username' do
    it 'must be assignable' do
      described_class.username = 'username'
      expect(described_class.username).to eq 'username'
    end

    it 'must raise an exception when not set' do
      if described_class.instance_variable_defined?(:@username)
        described_class.send(:remove_instance_variable, :@username)
      end
      expect { described_class.username }.to raise_error(ConfigurationError)
    end

    it 'must raise an exception when set to nil' do
      described_class.username = nil
      expect { described_class.username }.to raise_error(ConfigurationError)
    end
  end

  describe '#log' do
    let(:logger) { Logger.new(File::NULL) }

    it 'must pass message to logger with correct level' do
      described_class.logger = logger
      allow(logger).to receive(:debug).with('Infreemation') do |&block|
        expect(block.call).to eq 'my message'
      end
      described_class.log(:debug, 'my message')
    end

    it 'must not raise an exception when logger is nil' do
      described_class.logger = nil
      expect { described_class.log(:debug, 'my message') }.not_to raise_error
    end
  end
end
