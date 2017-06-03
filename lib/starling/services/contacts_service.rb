module Starling
  module Services
    # A service for accessing the Contacts API
    class ContactsService < BaseService
      # @param id [String] The Starling internal ID of the contact
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::ContactResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(id, params: {}, headers: {})
        response = api_service.make_request(:get, "/contacts/#{id}", params: params,
                                                                     headers: headers)
        resource.new(response: response)
      end

      # @param id [String] The Starling internal ID of the contact
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the body
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Faraday::Response] the raw response from the Starling Bank API
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def delete(id, params: {}, headers: {})
        api_service.make_request(:delete, "/contacts/#{id}", params: params,
                                                             headers: headers)
      end

      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Array<Resources::ContactResource>]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def list(params: {}, headers: {})
        response = api_service.make_request(:get, '/contacts', params: params,
                                                               headers: headers)
        build_collection_from_embedded_key(response, key: 'contacts', resource: resource)
      end

      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the body
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::ContactResource] the created contact
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def create(params:, headers: {})
        post_response = api_service.make_request(:post, '/contacts', params: params,
                                                                     headers: headers)

        get_response = api_service.make_request(
          :get,
          convert_location_header_to_relative_path(post_response.headers['Location']),
          headers: headers
        )

        resource.new(response: get_response)
      end

      private

      def resource
        Resources::ContactResource
      end
    end
  end
end
