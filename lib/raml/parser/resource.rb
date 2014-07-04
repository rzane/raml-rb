require 'forwardable'
require 'raml/resource'
require 'raml/parser/method'
require 'raml/parser/node'
require 'raml/errors/unknown_attribute_error'

module Raml
  class Parser
    class Resource < Node
      extend Forwardable

      METHODS = %w[get put post delete]
      BASIC_ATTRIBUTES = %w[]
      ATTRIBUTES = METHODS + BASIC_ATTRIBUTES + [/^\//]

      attr_accessor :parent_node, :resource
      def_delegators :@parent_node, :resources

      def parse(parent_node, uri_partial, data)
        @parent_node = parent_node
        @resource = Raml::Resource.new(@parent_node, uri_partial)

        data = prepare_attributes(data)
        parse_attributes(data)

        @resource
      end

      private

        def parse_attributes(data)
          data.each do |key, value|
            key = underscore(key)
            case key
            when *BASIC_ATTRIBUTES
              resource.send("#{key}=".to_sym, parse_value(value))
            when /^\//
              resources << Raml::Parser::Resource.new(self).parse(resource, key, parse_value(value))
            when *METHODS
              resource.methods << Raml::Parser::Method.new(self).parse(key, parse_value(value))
            when 'is'
              @trait_names = value
            else
              raise UnknownAttributeError.new "Unknown resource key: #{key}"
            end
          end
        end

    end
  end
end
