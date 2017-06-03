module Starling
  module Services
    # A service for accessing the Merchant Locations API
    class MerchantLocationsService < BaseService
      # @param merchant_id [String] The Starling internal ID of the merchant the merchant
      #                             location belongs to
      # @param merchant_location_id [String] The Starling internal ID of the merchant
      #                                      location
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::MerchantLocationResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(merchant_id, merchant_location_id, params: {}, headers: {})
        response = api_service.make_request(
          :get,
          "/merchants/#{merchant_id}/locations/#{merchant_location_id}",
          params: params,
          headers: headers
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
