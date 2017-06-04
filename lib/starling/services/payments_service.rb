module Starling
  module Services
    # A service for accessing the Payment API
    class PaymentsService < BaseService
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Array<Resources::PaymentResource>]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def list(params: {}, headers: {})
        response = api_service.make_request(:get,
                                            '/payments/scheduled',
                                            params: params,
                                            headers: headers)

        build_collection_from_embedded_key(response,
                                           key: 'paymentOrders',
                                           resource: resource)
      end

      private

      def resource
        Resources::PaymentResource
      end
    end
  end
end
