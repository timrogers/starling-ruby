module Starling
  module Resources
    # A resource representing an address in the response from the Addresses API
    class AddressResource < BaseResource
      # @return [String] the city where the address is located
      def city
        parsed_data['city']
      end

      # @return [String] the country where the addresses is located (e.g. "GBR")
      def country
        parsed_data['country']
      end

      # @return [String] the postcode of the address
      def postcode
        parsed_data['postcode']
      end

      # @return [String] the street address of the address
      def street_address
        parsed_data['streetAddress']
      end
    end
  end
end
