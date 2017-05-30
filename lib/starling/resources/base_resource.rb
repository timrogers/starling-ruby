require 'json'
require 'time'

module Starling
  module Resources
    class BaseResource
      # A resource can be instantiated with either a Faraday::Response, including a
      # #body, or with a Hash pre-parsed from JSON
      def initialize(response: nil, parsed_data: nil)
        if response.nil? && parsed_data.nil?
          raise ArgumentError, 'Either response or parsed_data must be provided to ' \
                               'instantiate a resource'
        end

        @response = response
        @parsed_data = parsed_data
      end

      private

      def present_datetime(iso8601_string)
        Time.parse(iso8601_string)
      end

      # Some strings returned by the API are specified as Enum types, with a specified
      # set of possible values. These are best represented in Ruby as symbols (e.g.
      # the Transaction API's `source` can have the value MASTER_CARD, which will become
      # :master_card.
      def symbolize_enum_string(enum_string)
        enum_string.downcase.to_sym
      end

      def parsed_data
        @parsed_data ||= JSON.parse(@response.body)
      end
    end
  end
end
