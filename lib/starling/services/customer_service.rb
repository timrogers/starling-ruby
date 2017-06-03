module Starling
  module Services
    class CustomerService < BaseService
      def get(options = {})
        resource.new(response: api_service.make_request(:get, '/customers', options))
      end

      private

      def resource
        Resources::CustomerResource
      end
    end
  end
end
