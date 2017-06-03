module Starling
  module Services
    # A service for accessing the Customer API
    class CustomerService < BaseService
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::CustomerResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(params: {}, headers: {})
        response = api_service.make_request(:get, '/customers', params: params,
                                                                headers: headers)
        resource.new(response: response)
      end

      private

      def resource
        Resources::CustomerResource
      end
    end
  end
end
