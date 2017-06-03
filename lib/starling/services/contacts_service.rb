module Starling
  module Services
    class ContactsService < BaseService
      def get(id, options = {})
        response = api_service.make_request(:get, "/contacts/#{id}", options)
        resource.new(response: response)
      end

      def delete(id, options = {})
        api_service.make_request(:delete, "/contacts/#{id}", options)
      end

      def list(options = {})
        response = api_service.make_request(:get, '/contacts', options)
        build_collection_from_embedded_key(response, key: 'contacts', resource: resource)
      end

      # When creating a contact, if the first request is successful, it returns a 202
      # with a Location header pointing to the newly-created resource.
      def create(options = {})
        post_response = api_service.make_request(:post, '/contacts', options)

        get_response = api_service.make_request(
          :get,
          convert_location_header_to_relative_path(post_response.headers['Location']),
          options_without_params(options)
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
