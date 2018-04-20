# frozen_string_literal: true

require 'json'
require 'rest_client'

module Infreemation
  ##
  # This class is responsible for communicating with the remote API server
  #
  class API
    class << self
      # The #get method is doing a POST request. This is because the
      # Infreemation API is expecting raw POST data and the Ruby net/http core
      # library understandably does not support this.
      def get(path, params)
        resource[path].post(with_auth(params), &parser)
      end

      def post(path, body)
        resource[path].post(with_auth(body), &parser)
      end

      private

      def with_auth(options)
        options.merge(
          key: Infreemation.api_key,
          username: Infreemation.username
        ).to_json
      end

      def resource
        RestClient::Resource.new(Infreemation.url)
      end

      def parser
        lambda do |response, _request, _result|
          JSON.parse(response.body, symbolize_names: true)
        end
      end
    end
  end
end
