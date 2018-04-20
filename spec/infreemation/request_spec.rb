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

    it 'must return a Request' do
      allow(Request).to receive(:new).and_return(request)
      allow(request).to receive(:save)
      expect(Request.create(attributes)).to be_a Request
    end
  end

  describe '.where' do
    let(:path) { double(:path) }
    let(:options) { { rt: 'published' } }

    before { allow(Request).to receive(:path).and_return(path) }

    it 'must get remote requests' do
      expect(API).to receive(:get).and_return({})
      Request.where(options)
    end

    it 'must return a Array' do
      allow(API).to receive(:get).and_return({})
      expect(Request.where(options)).to be_an Array
    end

    it 'must map response to Requests' do
      allow(API).to receive(:get).
        and_return(published: { request: [{ ref: '001' }] })
      request = Request.where(options).first
      expect(request).to be_an Request
      expect(request.attributes[:ref]).to eq '001'
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

    it 'must post remote request' do
      path = double(:path)
      allow(Request).to receive(:path).and_return(path)
      expect(API).to receive(:post).with(path, attributes).and_return({})
      request.save
    end

    it 'must merge response into attributes' do
      allow(API).to receive(:post).and_return(ref: '001')
      expect { request.save }.to change { request.attributes[:ref] }.
        from(nil).to('001')
    end

    it 'must return true' do
      allow(API).to receive(:post).and_return({})
      expect(request.save).to eq true
    end
  end
end
