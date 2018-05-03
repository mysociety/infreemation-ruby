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

  shared_examples 'errors' do
    it 'must rescue RestClient exceptions' do
      allow(RestClient::Resource).to receive(:new).
        and_raise(RestClient::Exception)
      expect { subject }.to raise_error(RequestError)
    end

    it 'must rescue JSON exceptions' do
      allow(JSON).to receive(:parse).
        and_raise(JSON::ParserError)
      expect { subject }.to raise_error(ResponseError)
    end

    context 'non-errors' do
      let(:response) { File.read('spec/fixtures/response_0.json') }

      it 'does not raise an error' do
        expect { subject }.to_not raise_error
      end
    end

    context 'authenication errors' do
      let(:response) { File.read('spec/fixtures/error_2.json') }
      specify { expect { subject }.to raise_error(AuthenticationError) }
    end

    context 'request errors' do
      let(:response) { File.read('spec/fixtures/error_3.json') }
      specify { expect { subject }.to raise_error(RequestError) }
    end

    context 'missing requester errors' do
      let(:response) { File.read('spec/fixtures/error_5.json') }
      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'missing contact errors' do
      let(:response) { File.read('spec/fixtures/error_6.json') }
      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'missing contact type errors' do
      let(:response) { File.read('spec/fixtures/error_7.json') }
      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'missing body errors' do
      let(:response) { File.read('spec/fixtures/error_8.json') }
      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'other generic errors' do
      let(:response) { File.read('spec/fixtures/error_n.json') }
      specify { expect { subject }.to raise_error(GenericError) }
    end

    context 'response errors' do
      let(:response) { 'invalid json' }
      specify { expect { subject }.to raise_error(ResponseError) }
    end
  end

  describe '.get' do
    let(:params) { { rt: 'published' } }
    let(:response) { '{ "foo": "bar" }' }
    subject { API.get('/foi', params) }

    include_examples 'errors'

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

    include_examples 'errors'

    it 'must not raise error' do
      expect { subject }.to_not raise_error
    end

    it 'must parse response' do
      expect(subject).to eq(baz: 'qux')
    end
  end
end
