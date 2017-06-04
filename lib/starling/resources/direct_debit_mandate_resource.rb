module Starling
  module Resources
    # A resource representing a Direct Debit mandate returned from the Direct Debit
    # Mandates API
    class DirectDebitMandateResource < BaseResource
      # @return [String] the Starling internal ID of the Direct Debit mandate
      def uid
        parsed_data['uid']
      end

      # @return [String] the reference of the Direct Debit mandate
      def reference
        parsed_data['reference']
      end

      # @return [Symbol] the status of the mandate (e.g. `:live`)
      def status
        present_enum(parsed_data['status'])
      end

      # @return [Symbol] the source of the mandate (e.g. `:electronic` or `paper)
      def source
        present_enum(parsed_data['source'])
      end

      # @return [Time] the date when the mandate was created
      def created
        present_datetime(parsed_data['created'])
      end
      alias created_at created

      # @return [String] the name of the Direct Debit mandate's originator
      def originator_name
        parsed_data['originatorName']
      end

      # @return [String] the Starling internal ID of the Direct Debit mandate's originator
      def originator_uid
        parsed_data['originatorUid']
      end
    end
  end
end
