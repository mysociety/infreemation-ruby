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

    context 'without errors' do
      let(:response) { File.read('spec/fixtures/response_0.json') }

      it 'does not raise an error' do
        expect { subject }.not_to raise_error
      end
    end

    context 'with authentication invalid errors' do
      let(:response) { File.read('spec/fixtures/error_2.json') }

      specify { expect { subject }.to raise_error(AuthenticationError) }
    end

    context 'with missing or invalid start date errors' do
      let(:response) { File.read('spec/fixtures/error_3.json') }

      specify do
        expect { subject }.to raise_error(MissingOrInvalidParameterError)
      end
    end

    context 'with invalid FOI type errors' do
      let(:response) { File.read('spec/fixtures/error_4.json') }

      specify { expect { subject }.to raise_error(InvalidParameterError) }
    end

    context 'with missing subject errors' do
      let(:response) { File.read('spec/fixtures/error_5.json') }

      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'with missing contact errors' do
      let(:response) { File.read('spec/fixtures/error_6.json') }

      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'with missing contact type errors' do
      let(:response) { File.read('spec/fixtures/error_7.json') }

      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'with missing body errors' do
      let(:response) { File.read('spec/fixtures/error_8.json') }

      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'with missing rt errors' do
      let(:response) { File.read('spec/fixtures/error_9.json') }

      specify { expect { subject }.to raise_error(MissingParameterError) }
    end

    context 'with authentication missing key errors' do
      let(:response) { File.read('spec/fixtures/error_10.json') }

      specify { expect { subject }.to raise_error(AuthenticationError) }
    end

    context 'with authentication missing username errors' do
      let(:response) { File.read('spec/fixtures/error_11.json') }

      specify { expect { subject }.to raise_error(AuthenticationError) }
    end

    context 'with request errors' do
      let(:response) { File.read('spec/fixtures/error_12.json') }

      specify { expect { subject }.to raise_error(RequestError) }
    end

    context 'with other generic errors' do
      let(:response) { File.read('spec/fixtures/error_n.json') }

      specify { expect { subject }.to raise_error(GenericError) }
    end

    context 'with response errors' do
      let(:response) { 'permission denied' }

      it 'raises resonse error with response body' do
        expect { subject }.to raise_error(
          ResponseError, 'JSON invalid (permission denied)'
        )
      end
    end

    context 'with long response errors' do
      let(:response) { 'x' * 101 }

      it 'trims response body' do
        expect { subject }.to raise_error(
          ResponseError, "JSON invalid (#{'x' * 100})"
        )
      end
    end
  end

  describe '.get' do
    subject(:request) { described_class.get('/foi', params) }

    let(:params) { { rt: 'published' } }
    let(:response) { '{ "foo": "bar" }' }

    include_examples 'errors'

    it 'must not raise error' do
      expect { request }.not_to raise_error
    end

    it 'must parse response' do
      expect(request).to eq(foo: 'bar')
    end
  end

  describe '.post' do
    subject(:request) { described_class.post('/foi', params) }

    let(:params) { { requester: 'Kirk' } }
    let(:response) { '{ "baz": "qux" }' }

    include_examples 'errors'

    it 'must not raise error' do
      expect { request }.not_to raise_error
    end

    it 'must parse response' do
      expect(request).to eq(baz: 'qux')
    end
  end
end
