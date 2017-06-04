require 'json'
require 'time'
require 'date'

module Starling
  module Resources
    # A basic implementation of a resource representing a response from the Starling Bank
    # API
    class BaseResource
      # A resource can be instantiated with either a Faraday::Response (including a
      # #body), or with a Hash pre-parsed from JSON.
      #
      # An alternative possible approach to our resources would be to parse out the
      # attributes we care about at initialisation, and then just add `attr_reader`s,
      # rather than looking into the parsed JSON hash. The current solution is probably
      # preferable, since it defers delving into the hash until a parameter is actually
      # wanted, and keeps instance variables to a minimum.
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

      # Many fields returned in the API (e.g. transaction amounts) can be either integers
      # or more complex values with decimal places. The JSON parser will turn these into
      # Integer (Fixnum in Ruby versions before 2.4) and Float objects respectively. For
      # consistency, we will convert anything that *could* be a Float into a Float.
      def present_float(number)
        Float(number)
      end

      # Some strings returned by the API are specified as Enum types, with a specified
      # set of possible values. These are best represented in Ruby as symbols (e.g.
      # the Transaction API's `source` can have the value MASTER_CARD, which will become
      # :master_card.
      def present_enum(enum_string)
        enum_string.downcase.to_sym
      end
    end
  end
end
