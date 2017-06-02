module Starling
  module Resources
    class MeResource < BaseResource
      def customer_uid
        parsed_data['customerUid']
      end

      def authenticated
        parsed_data['authenticated']
      end

      def expires_in_seconds
        parsed_data['expiresInSeconds']
      end

      def scopes
        parsed_data['scopes']
      end
    end
  end
end
