module Starling
  module Services
    class MerchantsService < BaseService
      def get(id, options = {})
        response = api_service.make_request(:get, "/merchants/#{id}", options)
        resource.new(response: response)
      end

      private

      def resource
        Resources::MerchantResource
      end
    end
  end
end
