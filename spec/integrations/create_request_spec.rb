# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'create request' do
  let(:attributes) do
    {
      rt: 'create',
      type: 'FOI',
      requester: 'Fred Smith',
      contact: 'fred@hotmail.com',
      contacttype: 'email',
      subject: 'Missed Bins',
      body: 'Dear FOI team, ...'
    }
  end

  let(:attributes_with_auth) do
    attributes.merge(key: 'APIkey', username: 'username')
  end

  before do
    Infreemation.url = 'https://api.infreemation.co.uk/sandbox'
    Infreemation.api_key = 'APIkey'
    Infreemation.username = 'username'

    stub_request(:post, 'https://api.infreemation.co.uk/sandbox/foi/').
      with(body: attributes_with_auth.to_json).to_return(body: response)
  end

  context 'without error' do
    subject(:request) { Request.create(attributes) }
    let(:response) { File.new('spec/fixtures/create_request_response.json') }

    it 'must return request' do
      is_expected.to be_a Request
    end
  end
end
