# frozen_string_literal: true

module Infreemation
  ##
  # This class represents a FOI or EIR request
  #
  class Request
    class << self
      def path
        '/foi/'
      end

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
      @attributes.merge!(API.post(self.class.path, attributes))
      true
    end
  end
end
