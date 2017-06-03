require 'json'

module Starling
  module Errors
    # An error raised when the Starling Bank API responds in a way indicating an error
    class ApiError < BaseError
      # @return [String] a helpful message explaining the error, incorporating the
      #                  HTTP status code and the error message (either parsed from the
      #                  JSON for a JSON response, or the whole body)
      def message
        # If there response isn't JSON or either the Starling-provided error or error
        # description is missing, return a simpler error from BaseError
        return super unless error && error_description

        "#{status}: #{error_description} (#{error})"
      end
      alias to_s message

      # @return [String] the error name returned by the Starling Bank API
      def error
        return unless json?
        parsed_body['error']
      end

      # @return [String] the error description returned by the Starling Bank API
      def error_description
        return unless json?
        parsed_body['error_description']
      end

      # @return [Hash] the parsed JSON response, if there is a valid JSON body
      # @return [nil] if there is no body, or the body is not valid JSON
      def parsed_body
        return unless body
        JSON.parse(body)
      rescue JSON::ParserError
        nil
      end

      private

      def json?
        parsed_body
      end
    end
  end
end
