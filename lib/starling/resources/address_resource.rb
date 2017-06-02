module Starling
  module Resources
    class AddressResource < BaseResource
      def city
        parsed_data['city']
      end

      def country
        parsed_data['country']
      end

      def postcode
        parsed_data['postcode']
      end

      def street_address
        parsed_data['streetAddress']
      end
    end
  end
end
