# frozen_string_literal: true

require 'spec_helper'

RSpec.describe API do
  before do
    Infreemation.url = 'http://example.com'
    Infreemation.api_key = '123'
    Infreemation.username = 'ABC'

    stub_request(:post, 'http://example.com/foi').
      with(body: params.merge(key: '123', username: 'ABC').to_json).
      to_return(body: response)
  end

  describe '.get' do
    let(:params) { { rt: 'published' } }
    let(:response) { '{ "foo": "bar" }' }
    subject { API.get('/foi', params) }

    it 'must not raise error' do
      expect { subject }.to_not raise_error
    end

    it 'must parse response' do
      expect(subject).to eq(foo: 'bar')
    end
  end

  describe '.post' do
    let(:params) { { requester: 'Kirk' } }
    let(:response) { '{ "baz": "qux" }' }
    subject { API.post('/foi', params) }

    it 'must not raise error' do
      expect { subject }.to_not raise_error
    end

    it 'must parse response' do
      expect(subject).to eq(baz: 'qux')
    end
  end
end
