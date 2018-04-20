# frozen_string_literal: true

module Infreemation
  ##
  # This class represents a FOI or EIR request
  #
  class Request
    class << self
      def create(attributes = {})
        new(attributes, &:save)
      end
    end

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
      yield self if block_given?
    end

    def save
      true
    end
  end
end
