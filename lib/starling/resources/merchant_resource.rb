module Starling
  module Resources
    class MerchantResource < BaseResource
      def merchant_uid
        parsed_data['merchantUid']
      end

      def name
        parsed_data['name']
      end

      def website
        parsed_data['website']
      end

      def phone_number
        parsed_data['phoneNumber']
      end

      def twitter_username
        parsed_data['twitterUsername']
      end
    end
  end
end
