module Starling
  module Services
    class MerchantLocationsService < BaseService
      def get(merchant_uid, merchant_location_uid, options = {})
        response = @api_service.make_request(
          :get,
          "/merchants/#{merchant_uid}/locations/#{merchant_location_uid}",
          options
        )

        resource.new(response: response)
      end

      private

      def resource
        Resources::MerchantLocationResource
      end
    end
  end
end
