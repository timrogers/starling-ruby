module Starling
  module Resources
    class AccountResource < BaseResource
      def created_at
        present_datetime(parsed_data['createdAt'])
      end

      def currency
        parsed_data['currency']
      end

      def iban
        parsed_data['iban']
      end

      def bic
        parsed_data['bic']
      end

      def id
        parsed_data['id']
      end

      def name
        parsed_data['name']
      end

      def number
        parsed_data['number']
      end

      def sort_code
        parsed_data['sortCode']
      end
    end
  end
end
