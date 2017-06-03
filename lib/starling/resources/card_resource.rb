module Starling
  module Resources
    # A resource representing a response from the Card API
    class CardResource < BaseResource
      # @return [String] the Starling internal ID of the card
      def id
        parsed_data['id']
      end

      # @return [String] the name on the front of the card
      def name_on_card
        parsed_data['nameOnCard']
      end

      # @return [String] the type of the card (e.g. "ContactlessDebitMastercard")
      def type
        parsed_data['type']
      end

      # @return [true, false] whether the card is enabled
      def enabled
        parsed_data['enabled']
      end

      # @return [true, false] whether the card has been cancelled
      def cancelled
        parsed_data['cancelled']
      end

      # @return [true, false] whether the card's activation has been requested
      def activation_requested
        parsed_data['activationRequested']
      end

      # @return [true, false] whether the card has been activated
      def activated
        parsed_data['activated']
      end

      # @return [Date] when the card was dispatched by post to the user
      def dispatch_date
        present_date(parsed_data['dispatchDate'])
      end
    end
  end
end
