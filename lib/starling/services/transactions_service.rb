module Starling
  module Services
    # A service for accessing the Transactions API
    class TransactionsService < BaseService
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::TransactionResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(id, params: {}, headers: {})
        response = api_service.make_request(:get,
                                            "/transactions/#{id}",
                                            params: params,
                                            headers: headers)
        resource.new(response: response)
      end

      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Array<Resources::TransactionResource>]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def list(params: {}, headers: {})
        response = api_service.make_request(:get, '/transactions', params: params,
                                                                   headers: headers)

        build_collection_from_embedded_key(response,
                                           key: 'transactions',
                                           resource: resource)
      end

      private

      def resource
        Resources::TransactionResource
      end
    end
  end
end
