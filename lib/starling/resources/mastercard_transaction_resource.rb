module Starling
  module Resources
    # A resource representing a Transaction returned from the Transactions Mastercard API
    class MastercardTransactionResource < BaseResource
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

      # @return [Symbol] the MasterCard transaction method of the transaction (e.g.
      #                  `:contactless`)
      def mastercard_transaction_method
        present_enum(parsed_data['mastercardTransactionMethod'])
      end

      # @return [Symbol] the status of the transaction (e.g. `:settled`)
      def status
        present_enum(parsed_data['status'])
      end

      # @return [String] the source currency of the transaction (e.g. "GBP" or "UAH")
      def source_currency
        parsed_data['sourceCurrency']
      end

      # @return [Float] the source amount of the transaction
      def source_amount
        present_float(parsed_data['sourceAmount'])
      end

      # @return [String] the Starling internal ID of the merchant
      def merchant_id
        parsed_data['merchantId']
      end

      # @return [String] the Starling internal ID of the merchant location
      def merchant_location_id
        parsed_data['merchantLocationId']
      end
    end
  end
end
