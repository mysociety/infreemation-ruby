# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Request do
  describe '.path' do
    it 'must be set' do
      expect(described_class.path).to eq '/foi/'
    end
  end

  describe '.create!' do
    let(:attributes) { { requester: 'James T. Kirk' } }
    let(:request) { described_class.new }

    it 'must initialise Request with attributes' do
      allow(described_class).to receive(:new)
      described_class.create!(attributes)
      expect(described_class).to have_received(:new).with(attributes)
    end

    it 'must yield save! to Request' do
      allow(described_class).to receive(:new).and_yield(request)
      allow(request).to receive(:save!)
      described_class.create!(attributes)
      expect(request).to have_received(:save!)
    end

    it 'must return the Request' do
      allow(described_class).to receive(:new).and_return(request)
      expect(described_class.create!(attributes)).to eq request
    end
  end

  describe '.where' do
    let(:path) { '/path' }
    let(:options) { { rt: 'published' } }

    before { allow(described_class).to receive(:path).and_return(path) }

    it 'must get remote requests' do
      allow(API).to receive(:get).and_return({})
      described_class.where(options)
      expect(API).to have_received(:get)
    end

    it 'must return a Array' do
      allow(API).to receive(:get).and_return({})
      expect(described_class.where(options)).to be_an Array
    end

    context 'with published requests response' do
      subject(:request) { described_class.where(options).first }

      before do
        allow(API).to receive(:get).
          and_return(published: { request: [{ ref: '001' }] })
      end

      it { is_expected.to be_a described_class }

      it 'must map response attributes to Request' do
        expect(request.attributes[:ref]).to eq '001'
      end
    end
  end

  describe '#initialize' do
    it 'must assign attributes' do
      request = described_class.new(requester: 'Spock')
      expect(request.attributes[:requester]).to eq 'Spock'
    end

    it 'must yield control' do
      expect { |block| described_class.new(&block) }.to yield_control
    end
  end

  describe '#save!' do
    let(:attributes) { { requester: 'Uhura' } }
    let(:request) { described_class.new(attributes) }

    it 'must post remote request' do
      path = '/path'
      allow(described_class).to receive(:path).and_return(path)
      allow(API).to receive(:post).and_return({})
      request.save!
      expect(API).to have_received(:post).with(path, attributes)
    end

    it 'must merge response into attributes' do
      allow(API).to receive(:post).and_return(ref: '001')
      expect { request.save! }.to change { request.attributes[:ref] }.
        from(nil).to('001')
    end

    it 'must return true' do
      allow(API).to receive(:post).and_return({})
      expect(request.save!).to eq true
    end
  end
end
