module Starling
  module Resources
    # A resource representing a response returned from the Who Am I (Me) API
    class MeResource < BaseResource
      # @return [String] the Starling internal ID of the user
      def customer_uid
        parsed_data['customerUid']
      end

      # @return [true, false] whether the user is authenticated
      def authenticated
        parsed_data['authenticated']
      end

      # @return [Integer, Fixnum] the time until the user's access token expires
      def expires_in_seconds
        parsed_data['expiresInSeconds']
      end

      # @return [Array<String>] the scopes of the user's access token
      def scopes
        parsed_data['scopes']
      end
    end
  end
end
