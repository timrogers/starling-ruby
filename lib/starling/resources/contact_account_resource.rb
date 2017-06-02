module Starling
  module Resources
    class ContactAccountResource < BaseResource
      def id
        parsed_data['id']
      end

      def name
        parsed_data['name']
      end

      def type
        symbolize_enum_string(parsed_data['type'])
      end

      def account_number
        parsed_data['accountNumber']
      end

      def sort_code
        parsed_data['sortCode']
      end
    end
  end
end
