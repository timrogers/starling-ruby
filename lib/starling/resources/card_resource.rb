module Starling
  module Resources
    class CardResource < BaseResource
      def id
        parsed_data['id']
      end

      def name_on_card
        parsed_data['nameOnCard']
      end

      def type
        parsed_data['type']
      end

      def enabled
        parsed_data['enabled']
      end

      def cancelled
        parsed_data['cancelled']
      end

      def activation_requested
        parsed_data['activationRequested']
      end

      def activated
        parsed_data['activated']
      end

      def dispatch_date
        present_date(parsed_data['dispatchDate'])
      end
    end
  end
end
