# frozen_string_literal: true

require 'json'
require 'rest_client'

module Infreemation
  ##
  # This class is responsible for communicating with the remote API server
  #
  class API
    class << self
      def post(path, body)
        resource[path].post(with_auth(body))
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
    end
  end
end
