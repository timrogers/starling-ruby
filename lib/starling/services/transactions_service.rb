module Starling
  module Services
    class TransactionsService < BaseService
      def get(id, options = {})
        response = api_service.make_request(:get, "/transactions/#{id}", options)
        resource.new(response: response)
      end

      def list(options = {})
        response = api_service.make_request(:get, '/transactions', options)

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
