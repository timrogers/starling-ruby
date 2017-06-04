module Starling
  module Resources
    # A resource representing a response from the Account Balance API
    class AccountBalanceResource < BaseResource
      # @return [Float] the account's accepted overdraft
      def accepted_overdraft
        present_float(parsed_data['acceptedOverdraft'])
      end

      # @return [Float] the account's balance
      def amount
        present_float(parsed_data['amount'])
      end

      # @return [Float] the account's amount available to spend
      def available_to_spend
        present_float(parsed_data['availableToSpend'])
      end

      # @return [Float] the account's cleared balance
      def cleared_balance
        present_float(parsed_data['clearedBalance'])
      end

      # @return [String] the account's currency (e.g. "GBP")
      def currency
        parsed_data['currency']
      end

      # @return [Float] the account's effective balance
      def effective_balance
        present_float(parsed_data['effectiveBalance'])
      end

      # @return [Float] the total of the account's pending transactions
      def pending_transactions
        present_float(parsed_data['pendingTransactions'])
      end
    end
  end
end
