module Starling
  module Resources
    class AddressesResource < BaseResource
      def current
        AddressResource.new(parsed_data: parsed_data['current'])
      end

      def previous
        parsed_data['previous'].map do |address|
          AddressResource.new(parsed_data: address)
        end
      end
    end
  end
end
