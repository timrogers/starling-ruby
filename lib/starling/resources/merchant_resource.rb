module Starling
  module Resources
    # A resource representing a Merchant returned from the Merchants API
    class MerchantResource < BaseResource
      # @return [String] the Starling internal ID of the merchant
      def merchant_uid
        parsed_data['merchantUid']
      end

      # @return [String] the name of the merchant
      def name
        parsed_data['name']
      end

      # @return [String, nil] the website address of the merchant, or nil if this is not
      #                       known
      def website
        parsed_data['website']
      end

      # @return [String, nil] the phone number of the merchant, or nil if this is not
      #                       known
      def phone_number
        parsed_data['phoneNumber']
      end

      # @return [String, nil] the Twitter username of the merchant, prefixed with "@", or
      #                       nil if this is not known
      def twitter_username
        parsed_data['twitterUsername']
      end
    end
  end
end
