# frozen_string_literal: true

module Infreemation
  ##
  # A base error
  #
  Exception = Class.new(StandardError)

  ##
  # A generic error
  #
  GenericError = Class.new(Exception)

  ##
  # An API authentication error
  #
  AuthenticationError = Class.new(Exception)

  ##
  # A request error
  #
  RequestError = Class.new(Exception)

  ##
  # A response error
  #
  ResponseError = Class.new(Exception)

  ##
  # A missing parameter error
  #
  MissingParameterError = Class.new(Exception)

  ERROR_MAPPINGS = {
    2 => AuthenticationError,
    3 => RequestError,
    5 => MissingParameterError, # requester
    6 => MissingParameterError, # contact
    7 => MissingParameterError, # contacttype
    8 => MissingParameterError  # body
  }.freeze

  ##
  # This module is responsible for mapping error codes into the correct type to
  # exception class
  #
  module Errors
    def self.[](code)
      ERROR_MAPPINGS[code.to_i] || GenericError
    end
  end
end
