module Starling
  module Services
    class ContactAccountsService < BaseService
      def get(contact_id, account_id, options = {})
        response = @api_service.make_request(
          :get,
          "/contacts/#{contact_id}/accounts/#{account_id}",
          options
        )

        resource.new(response: response)
      end

      def list(contact_id, options = {})
        response = @api_service.make_request(
          :get,
          "/contacts/#{contact_id}/accounts",
          options
        )

        build_collection_from_key(response, key: 'contactAccounts', resource: resource)
      end

      private

      def resource
        Resources::ContactAccountResource
      end
    end
  end
end
