module Starling
  module Resources
    # A resource representing a response from the Addresses API
    class AddressesResource < BaseResource
      # @return [AddressResource] the user's current address
      def current
        AddressResource.new(parsed_data: parsed_data['current'])
      end

      # @return [Array<AddressResource>] a list of the user's previous addresses
      def previous
        parsed_data['previous'].map do |address|
          AddressResource.new(parsed_data: address)
        end
      end
    end
  end
end
