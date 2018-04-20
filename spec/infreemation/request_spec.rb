# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Request do
  describe '.path' do
    it 'must be set' do
      expect(Request.path).to eq '/foi/'
    end
  end

  describe '.create' do
    let(:attributes) { { requester: 'James T. Kirk' } }
    let(:request) { Request.new }

    it 'must initialise Request and call save' do
      expect(request).to receive(:save)
      expect(Request).to receive(:new) do |&blk|
        blk.call(request)
      end
      Request.create(attributes)
    end
  end

  describe '#initialize' do
    it 'must assign attributes' do
      request = Request.new(requester: 'Spock')
      expect(request.attributes[:requester]).to eq 'Spock'
    end

    it 'must yield control' do
      expect { |block| Request.new(&block) }.to yield_control
    end
  end

  describe '#save' do
    let(:attributes) { { requester: 'Uhura' } }
    let(:request) { Request.new(attributes) }

    it 'must return true' do
      expect(request.save).to eq true
    end
  end
end
