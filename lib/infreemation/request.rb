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

      def create!(attributes = {})
        new(attributes, &:save!)
      end

      def where(options = {})
        type = options.fetch(:rt).downcase.to_sym
        requests_data = API.get(path, options).dig(type, :request) || []
        requests_data.map { |attributes| new(attributes) }
      end
    end

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
      yield self if block_given?
    end

    def save!
      @attributes.merge!(API.post(self.class.path, attributes))
      true
    end
  end
end
