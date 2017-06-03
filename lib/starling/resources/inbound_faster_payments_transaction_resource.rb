module Starling
  module Resources
    # A resource representing a Transaction returned from the Transactions Faster
    # Payments In API
    class InboundFasterPaymentsTransactionResource < BaseResource
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
        parsed_data['amount']
      end

      # @return [Symbol] the direction of the transaction (e.g. `:outbound`)
      def direction
        symbolize_enum_string(parsed_data['direction'])
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
        symbolize_enum_string(parsed_data['source'])
      end

      # @return [String, nil] the Starling internal ID of the contact who sent the
      #                       payment, or nil if they are not one of the user's contacts
      def sending_contact_id
        parsed_data['sendingContactId']
      end

      # @return [String, nil] the Starling internal ID of the contact account which sent
      #                       the payment, or nil if they are not one of the user's
      #                       contacts
      def sending_contact_account_id
        parsed_data['sendingContactAccountId']
      end
    end
  end
end
