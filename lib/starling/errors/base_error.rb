require 'json'

module Starling
  module Errors
    class BaseError < StandardError
      extend Forwardable

      def initialize(env)
        @env = env
      end

      def_delegator :@env, :status
      def_delegator :@env, :body

      def message
        message = status.to_s
        message += ": #{body}" if body

        message
      end

      alias to_s message

      def error
        return unless json?
        parsed_body['error']
      end

      def error_description
        return unless json?
        parsed_body['error_description']
      end

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
