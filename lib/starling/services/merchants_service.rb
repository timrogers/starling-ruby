module Starling
  module Services
    # A service for accessing the Merchant API's Get Merchant endpoint
    class MerchantsService < BaseService
      # @param id [String] The Starling internal ID of the merchant
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources:MerchantResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(id, params: {}, headers: {})
        response = api_service.make_request(:get, "/merchants/#{id}", params: params,
                                                                      headers: headers)
        resource.new(response: response)
      end

      private

      def resource
        Resources::MerchantResource
      end
    end
  end
end
