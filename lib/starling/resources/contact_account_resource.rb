module Starling
  module Resources
    # A resource representing a Contact Account returned from the Contact Accounts API
    class ContactAccountResource < BaseResource
      # @return [String] the Starling internal ID of the contact account
      def id
        parsed_data['id']
      end

      # @return [String] the name of the contact account
      def name
        parsed_data['name']
      end

      # @return [Symbol] the type of the contact account (e.g. `:domestic`)
      def type
        present_enum(parsed_data['type'])
      end

      # @return [String] the account number of the contact account
      def account_number
        parsed_data['accountNumber']
      end

      # @return [String] the sort code of the contact account
      def sort_code
        parsed_data['sortCode']
      end
    end
  end
end
