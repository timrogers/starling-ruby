module Starling
  module Services
    class AccountService < BaseService
      def get(options = {})
        resource.new(response: @api_service.make_request(:get, '/accounts', options))
      end

      def balance
        Services::AccountBalanceService.new(@api_service)
      end

      private

      def resource
        Resources::AccountResource
      end
    end
  end
end
