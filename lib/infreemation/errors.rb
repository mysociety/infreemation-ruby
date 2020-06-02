# frozen_string_literal: true

module Infreemation
  ##
  # A base error
  #
  Exception = Class.new(StandardError)

  ##
  # A generic error
  #
  GenericError = Class.new(RuntimeError)

  ##
  # An API authentication error
  #
  AuthenticationError = Class.new(RuntimeError)

  ##
  # A request error
  #
  RequestError = Class.new(RuntimeError)

  ##
  # A response error
  #
  ResponseError = Class.new(RuntimeError)

  ##
  # A missing parameter error
  #
  MissingParameterError = Class.new(RuntimeError)

  ##
  # An invalid parameter error
  #
  InvalidParameterError = Class.new(RuntimeError)

  ##
  # A missing or invalid parameter error
  #
  MissingOrInvalidParameterError = Class.new(RuntimeError)

  ERROR_MAPPINGS = {
    2 => AuthenticationError, # key or username invalid
    3 => MissingOrInvalidParameterError, # start date
    4 => InvalidParameterError, # FOI type
    5 => MissingParameterError, # requester
    6 => MissingParameterError, # contact
    7 => MissingParameterError, # contacttype
    8 => MissingParameterError, # body
    9 => MissingParameterError, # rt
    10 => AuthenticationError, # key missing
    11 => AuthenticationError, # username missing
    12 => RequestError # no data
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
