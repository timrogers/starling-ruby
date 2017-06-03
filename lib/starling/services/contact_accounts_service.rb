module Starling
  module Services
    # A service for accessing the Contact Accounts API
    class ContactAccountsService < BaseService
      # @param contact_id [String] The Starling internal ID of the contact the contact
      #                            account belongs to
      # @param contact_account_id [String] The Starling internal ID of the contact
      #                                     account
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::ContactAccountResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(contact_id, contact_account_id, params: {}, headers: {})
        response = api_service.make_request(
          :get,
          "/contacts/#{contact_id}/accounts/#{contact_account_id}",
          params: params,
          headers: headers
        )

        resource.new(response: response)
      end

      # @param contact_id [String] The Starling internal ID of the contact
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Array<Resources::ContactAccountResource>]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def list(contact_id, params: {}, headers: {})
        response = api_service.make_request(
          :get,
          "/contacts/#{contact_id}/accounts",
          params: params,
          headers: headers
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
