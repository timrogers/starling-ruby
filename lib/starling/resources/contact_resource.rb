module Starling
  module Resources
    # A resource representing a Contact returned from the Contacts API
    class ContactResource < BaseResource
      # @return [String] the Starling internal ID of the contact
      def id
        parsed_data['id']
      end

      # @return [String] the name of the contact
      def name
        parsed_data['name']
      end
    end
  end
end
