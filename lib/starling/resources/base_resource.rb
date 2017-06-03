require 'json'
require 'time'
require 'date'

module Starling
  module Resources
    # A basic implementation of a resource representing a response from the Starling Bank
    # API
    class BaseResource
      # A resource can be instantiated with either a Faraday::Response (including a
      # #body), or with a Hash pre-parsed from JSON
      #
      # @param response [Faraday::Response] The complete HTTP response, returned by
      #                                     {Request#make_request}
      # @param parsed_data [Hash] The pre-parsed data for the resource, useful for
      #                           building resources from list resources we've already
      #                           parsed
      def initialize(response: nil, parsed_data: nil)
        unless response || parsed_data
          raise ArgumentError, 'Either response or parsed_data must be provided to ' \
                               'instantiate a resource'
        end

        @response = response
        @parsed_data = parsed_data || JSON.parse(response.body)
      end

      private

      attr_reader :parsed_data

      def present_datetime(iso8601_string)
        Time.parse(iso8601_string)
      end

      def present_date(string)
        Date.parse(string)
      end

      # Some strings returned by the API are specified as Enum types, with a specified
      # set of possible values. These are best represented in Ruby as symbols (e.g.
      # the Transaction API's `source` can have the value MASTER_CARD, which will become
      # :master_card.
      def symbolize_enum_string(enum_string)
        enum_string.downcase.to_sym
      end
    end
  end
end
