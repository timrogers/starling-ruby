module Starling
  module Resources
    class TransactionResource < BaseResource
      def id
        parsed_data['id']
      end

      def currency
        parsed_data['currency']
      end

      def amount
        parsed_data['amount']
      end

      def direction
        symbolize_enum_string(parsed_data['direction'])
      end

      def created
        present_datetime(parsed_data['created'])
      end
      alias created_at created

      def narrative
        parsed_data['narrative']
      end

      def source
        symbolize_enum_string(parsed_data['source'])
      end
    end
  end
end
