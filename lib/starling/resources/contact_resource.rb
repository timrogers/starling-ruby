module Starling
  module Resources
    class ContactResource < BaseResource
      def id
        parsed_data['id']
      end

      def name
        parsed_data['name']
      end
    end
  end
end
