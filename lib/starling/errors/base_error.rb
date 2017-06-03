require 'json'

module Starling
  module Errors
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
