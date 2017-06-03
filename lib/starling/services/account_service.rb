module Starling
  module Services
    # A service for accessing the Account API
    class AccountService < BaseService
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::AccountResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(params: {}, headers: {})
        response = api_service.make_request(:get, '/accounts', params: params,
                                                               headers: headers)

        resource.new(response: response)
      end

      # @return [Services::AccountBalanceService] a configured service for accessing the
      #                                           Account Balance API
      def balance
        Services::AccountBalanceService.new(api_service)
      end

      private

      def resource
        Resources::AccountResource
      end
    end
  end
end
