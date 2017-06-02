module Starling
  module Services
    class CardService < BaseService
      def get(options = {})
        resource.new(response: @api_service.make_request(:get, '/cards', options))
      end

      private

      def resource
        Resources::CardResource
      end
    end
  end
end
