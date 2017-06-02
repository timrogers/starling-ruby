module Starling
  module Resources
    class DirectDebitMandateResource < BaseResource
      def uid
        parsed_data['uid']
      end

      def reference
        parsed_data['reference']
      end

      def status
        symbolize_enum_string(parsed_data['status'])
      end

      def source
        symbolize_enum_string(parsed_data['source'])
      end

      def created
        present_datetime(parsed_data['created'])
      end
      alias created_at created

      def originator_name
        parsed_data['originatorName']
      end

      def originator_uid
        parsed_data['originatorUid']
      end
    end
  end
end
