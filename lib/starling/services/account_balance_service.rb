module Starling
  module Services
    class AccountBalanceService < BaseService
      def get(options = {})
        response = api_service.make_request(:get, '/accounts/balance', options)
        resource.new(response: response)
      end

      private

      def resource
        Resources::AccountBalanceResource
      end
    end
  end
end
