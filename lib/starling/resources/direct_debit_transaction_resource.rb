module Starling
  module Resources
    # A resource representing a Transaction returned from the Transaction Direct Debit
    # API
    class DirectDebitTransactionResource < BaseResource
      # @return [String] the Starling internal ID of the transaction
      def id
        parsed_data['id']
      end

      # @return [String] the currency of the transaction (e.g. "GBP" or "UAH")
      def currency
        parsed_data['currency']
      end

      # @return [Float] the amount of the transaction
      def amount
        present_float(parsed_data['amount'])
      end

      # @return [Symbol] the direction of the transaction (e.g. `:outbound`)
      def direction
        present_enum(parsed_data['direction'])
      end

      # @return [Time] the date and time when the transaction was recorded
      def created
        present_datetime(parsed_data['created'])
      end
      alias created_at created

      # @return [String] the narrative of the transaction
      def narrative
        parsed_data['narrative']
      end

      # @return [Symbol] the source of the transaction (e.g. `:master_card`)
      def source
        present_enum(parsed_data['source'])
      end

      # @return [String] the Starling internal ID of the Direct Debit mandate
      def mandate_id
        parsed_data['mandateId']
      end

      # @return [Symbol] the type of the transaction
      #                  (e.g. `:first_payment_of_direct_debit` or `:direct_debit`)
      def type
        present_enum(parsed_data['type'])
      end
    end
  end
end
