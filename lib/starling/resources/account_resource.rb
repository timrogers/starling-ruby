module Starling
  module Resources
    # A resource representing a response from the Account API
    class AccountResource < BaseResource
      # @return [Time] the time and date when the account was created
      def created_at
        present_datetime(parsed_data['createdAt'])
      end

      # @return [String] the currency of the account
      def currency
        parsed_data['currency']
      end

      # @return [String] the IBAN of the account
      def iban
        parsed_data['iban']
      end

      # @return [String] the BIC of the account
      def bic
        parsed_data['bic']
      end

      # @return [String] the Starling internal ID of the account
      def id
        parsed_data['id']
      end

      # @return [String] the name of the account
      def name
        parsed_data['name']
      end

      # @return [String] the account number of the account
      def number
        parsed_data['number']
      end
      alias account_number number

      # @return [String] the sort code of the account
      def sort_code
        parsed_data['sortCode']
      end
    end
  end
end
