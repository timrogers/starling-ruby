module Starling
  module Resources
    class MerchantLocationResource < BaseResource
      def merchant_uid
        parsed_data['merchantUid']
      end

      def merchant_location_uid
        parsed_data['merchantLocationUid']
      end

      def merchant_name
        parsed_data['merchantName']
      end

      def location_name
        parsed_data['locationName']
      end

      def mastercard_merchant_category_code
        parsed_data['mastercardMerchantCategoryCode']
      end
    end
  end
end
