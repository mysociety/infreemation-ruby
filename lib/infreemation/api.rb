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
        Infreemation.log :debug, "GET #{path} with #{params.inspect}"
        resource[path].post(with_auth(params), &parser)
      rescue RestClient::Exception => e
        raise RequestError, e.message
      end

      def post(path, body)
        Infreemation.log :debug, "POST #{path} with #{body.inspect}"
        resource[path].post(with_auth(body), &parser)
      rescue RestClient::Exception => e
        raise RequestError, e.message
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
          Infreemation.log :debug, response.body
          begin
            JSON.parse(response.body, symbolize_names: true).tap do |data|
              raise Errors[data[:ref]], data[:error] if data[:status] == 'ERROR'
            end
          rescue JSON::ParserError
            raise ResponseError, "JSON invalid (#{response.body[0...100]})"
          end
        end
      end
    end
  end
end
