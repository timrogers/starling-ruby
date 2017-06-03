module Starling
  module Services
    # A service for accessing the Direct Debit Mandates API
    class DirectDebitMandatesService < BaseService
      # @param id [String] The Starling internal ID of the Direct Debit mandate
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Resources::DirectDebitMandateResource]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def get(id, params: {}, headers: {})
        response = api_service.make_request(:get,
                                            "/direct-debit/mandates/#{id}",
                                            params: params,
                                            headers: headers)
        resource.new(response: response)
      end

      # Cancels a Direct Debit mandate
      #
      # @param id [String] The Starling internal ID of the Direct Debit mandate
      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the body
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Faraday::Response] the raw response from the Starling Bank API
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def delete(id, params: {}, headers: {})
        api_service.make_request(:delete,
                                 "/direct-debit/mandates/#{id}",
                                 params: params,
                                 headers: headers)
      end

      # @param params [Hash] Parameters which will be included in the HTTP request,
      #                      included in the URL as a query string
      # @param headers [Hash] Headers which be included in the HTTP request, merged on
      #                       top of the headers set at the {Client} level
      # @return [Array<Resources::DirectDebitMandateResource>]
      # @raise [Errors::ApiError] if the HTTP request returns a status indicating that it
      #                           was unsuccessful
      def list(params: {}, headers: {})
        response = api_service.make_request(:get,
                                            '/direct-debit/mandates',
                                            params: params,
                                            headers: headers)

        build_collection_from_embedded_key(response, key: 'mandates', resource: resource)
      end

      private

      def resource
        Resources::DirectDebitMandateResource
      end
    end
  end
end
