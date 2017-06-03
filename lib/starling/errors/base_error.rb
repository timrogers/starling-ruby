require 'json'

module Starling
  module Errors
    # A basic implementation of an error thrown from a {Faraday::Response::Middleware},
    # receiving the Faraday environment as an argument, providing access to the response
    # status and body
    class BaseError < StandardError
      extend Forwardable

      # @param env The Faraday environment, providing access to the response
      def initialize(env)
        @env = env
      end

      def_delegator :@env, :status
      def_delegator :@env, :body

      # @return [String] a helpful message explaining the error, incorporating the
      #                  HTTP status code and body returned
      def message
        message = status.to_s
        message += ": #{body}" if body

        message
      end
      alias to_s message
    end
  end
end
