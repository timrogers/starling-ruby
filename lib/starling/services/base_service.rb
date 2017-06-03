require 'json'

module Starling
  module Services
    class BaseService
      def initialize(api_service)
        @api_service = api_service
      end

      private

      attr_reader :api_service

      def build_collection_from_key(response, key:, resource:)
        JSON.parse(response.body)
            .fetch(key)
            .map do |parsed_data|
          resource.new(parsed_data: parsed_data)
        end
      end

      def build_collection_from_embedded_key(response, key:, resource:)
        JSON.parse(response.body)
            .fetch('_embedded', {})
            .fetch(key, []).map do |parsed_data|
          resource.new(parsed_data: parsed_data)
        end
      end

      def options_without_params(options)
        options.reject { |key, _| key == :params }
      end

      def convert_location_header_to_relative_path(location)
        location.gsub(%r{^/api/v1}, '')
      end
    end
  end
end
