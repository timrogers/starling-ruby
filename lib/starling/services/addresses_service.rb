module Starling
  module Services
    class AddressesService < BaseService
      def get(options = {})
        resource.new(response: @api_service.make_request(:get, '/addresses', options))
      end

      private

      def resource
        Resources::AddressesResource
      end
    end
  end
end
