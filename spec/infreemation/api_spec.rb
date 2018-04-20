# frozen_string_literal: true

require 'spec_helper'

RSpec.describe API do
  before do
    Infreemation.url = 'http://example.com'
    Infreemation.api_key = '123'
    Infreemation.username = 'ABC'
  end

  describe '.get' do
    let(:params) { { rt: 'published' } }
    let(:params_with_auth) { params.merge(key: '123', username: 'ABC') }

    before do
      stub_request(:post, 'http://example.com/foi').
        with(body: params_with_auth.to_json).
        to_return(body: '{ "foo": "bar" }')
    end

    it 'must not raise error' do
      expect { API.get('/foi', params) }.to_not raise_error
    end

    it 'must parse response' do
      expect(API.get('/foi', params)).to eq(foo: 'bar')
    end
  end

  describe '.post' do
    let(:body) { { requester: 'Kirk' } }
    let(:body_with_auth) { body.merge(key: '123', username: 'ABC') }

    before do
      stub_request(:post, 'http://example.com/foi').
        with(body: body_with_auth.to_json).
        to_return(body: '{ "baz": "qux" }')
    end

    it 'must not raise error' do
      expect { API.post('/foi', body) }.to_not raise_error
    end

    it 'must parse response' do
      expect(API.post('/foi', body)).to eq(baz: 'qux')
    end
  end
end
