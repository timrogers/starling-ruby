module Starling
  module Resources
    # A resource representing a Payment returned from the Payment API
    class PaymentResource < BaseResource
      # @return [String] the Starling internal ID of the payment
      def payment_order_id
        parsed_data['paymentOrderId']
      end
      alias id payment_order_id

      # @return [String] the currency of the payment
      def currency
        parsed_data['currency']
      end

      # @return [Float] the amount of the payment
      def amount
        present_float(parsed_data['amount'])
      end

      # @return [String] the reference of the payment
      def reference
        parsed_data['reference']
      end

      # @return [String] the Starling internal ID of the contact account the payment
      #                  is/was sent to
      def receiving_contact_account_id
        parsed_data['receivingContactAccountId']
      end

      # @return [String] the name of the recipient of the payment
      def recipient_name
        parsed_data['recipientName']
      end

      # @return [true, false] where the payment is immediate or scheduled for the future
      def immediate
        parsed_data['immediate']
      end

      # Returns a Hash describing the recurrence behaviour of the payment, or nil if the
      # payment is not recurring. The values in the Hash will be parsed directly from
      # JSON (e.g. dates will appear as strings).
      #
      # TODO: Consider replacing this with its own resource
      #
      # @return [Hash, nil] a Hash describing the recurrence behaviour of the payment,
      #                     with values parsed directly from JSON, or nil if the payment
      #                     is not recurring
      def recurrence_rule
        parsed_data['recurrenceRule']
      end

      # @return [Date] the start date of the payment
      def start_date
        present_date(parsed_data['startDate'])
      end

      # @return [Date] the date of the next payment in the series
      def next_date
        present_date(parsed_data['nextDate'])
      end

      # @return [Time, nil] the time when the payment was cancelled, or nil if it has not
      #                     been cancelled
      def cancelled_at
        present_datetime(parsed_data['cancelledAt'])
      end

      # @return [Symbol] the type of the payment (e.g. `:standing_order`) (these values
      #                  do not seem to be accurate!)
      def payment_type
        symbolize_enum_string(parsed_data['paymentType'])
      end
    end
  end
end
