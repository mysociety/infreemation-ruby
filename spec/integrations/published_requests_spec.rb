# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'published requests', type: :feature do
  subject(:array) { Request.where(attributes) }

  let(:attributes) do
    {
      rt: 'published',
      startdate: '2010-01-01',
      enddate: '2010-12-31'
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
    let(:response) do
      File.new('spec/fixtures/published_requests_response.json')
    end

    it { is_expected.to be_an Array }
    it { is_expected.not_to be_empty }

    it 'must return a collection of requests parsed from the response' do
      request_refs = array.map { |request| request.attributes[:ref] }
      expect(request_refs).to match_array(%w[FOI-18/01 FOI-18/02])
    end
  end

  context 'with authenciation error' do
    let(:response) do
      File.new('spec/fixtures/error_2.json')
    end

    it 'must raise error' do
      expect { array }.to raise_error(AuthenticationError)
    end
  end
end
