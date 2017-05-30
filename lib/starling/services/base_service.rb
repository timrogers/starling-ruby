require 'json'

module Starling
  module Services
    class BaseService
      def initialize(api_service)
        @api_service = api_service
      end

      private

      def build_collection(response, key:, resource:)
        JSON.parse(response.body)
            .fetch('_embedded', {})
            .fetch(key, []).map do |parsed_data|
          resource.new(parsed_data: parsed_data)
        end
      end
    end
  end
end
