module Starling
  module Resources
    class AccountBalanceResource < BaseResource
      def accepted_overdraft
        parsed_data['acceptedOverdraft']
      end

      def amount
        parsed_data['amount']
      end

      def available_to_spend
        parsed_data['availableToSpend']
      end

      def cleared_balance
        parsed_data['clearedBalance']
      end

      def currency
        parsed_data['currency']
      end

      def effective_balance
        parsed_data['effectiveBalance']
      end

      def pending_transactions
        parsed_data['pendingTransactions']
      end
    end
  end
end
