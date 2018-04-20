# frozen_string_literal: true

require 'spec_helper'

RSpec.describe API do
  before do
    Infreemation.url = 'http://example.com'
    Infreemation.api_key = '123'
    Infreemation.username = 'ABC'
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
