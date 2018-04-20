# frozen_string_literal: true

require 'infreemation/version'

##
# This module is the main entry point of the Gem
#
module Infreemation
  ConfigurationError = Class.new(StandardError)

  class << self
    attr_writer :url, :api_key, :username

    def url
      @url || raise(
        ConfigurationError, 'Infreemation.url not configured'
      )
    end

    def api_key
      @api_key || raise(
        ConfigurationError, 'Infreemation.api_key not configured'
      )
    end

    def username
      @username || raise(
        ConfigurationError, 'Infreemation.username not configured'
      )
    end
  end
end
