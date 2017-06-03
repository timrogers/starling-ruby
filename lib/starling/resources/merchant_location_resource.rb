module Starling
  module Resources
    # A resource representing a Merchant Location returned from the Merchant Locations API
    class MerchantLocationResource < BaseResource
      # @return [String] the Starling internal ID of the merchant
      def merchant_uid
        parsed_data['merchantUid']
      end

      # @return [String] the Starling internal ID of the merchant location
      def merchant_location_uid
        parsed_data['merchantLocationUid']
      end

      # @return [String] the name of the merchant
      def merchant_name
        parsed_data['merchantName']
      end

      # @return [String] the name of the merchant location
      def location_name
        parsed_data['locationName']
      end

      # @return [Integer, Fixnum] the MasterCard merchant category code - see
      #                           {https://www.mastercard.us/content/dam/mccom/en-us/docments/rules/quick-reference-booklet-me-nov_2015.pdf here}
      #                           for details
      def mastercard_merchant_category_code
        parsed_data['mastercardMerchantCategoryCode']
      end
    end
  end
end
