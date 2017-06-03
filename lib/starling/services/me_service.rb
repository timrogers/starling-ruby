module Starling
  module Services
    class MeService < BaseService
      def get(options = {})
        resource.new(response: api_service.make_request(:get, '/me', options))
      end

      private

      def resource
        Resources::MeResource
      end
    end
  end
end
