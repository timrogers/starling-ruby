module Starling
  module Middlewares
    # A Faradfay::Response::Middleware used to raise an {{Errors::ApiError}} when the
    # Starling Bank API responds with an HTTP status code indicating an error. The raised
    # error provides access to the response.
    class RaiseStarlingErrors < Faraday::Response::Middleware
      # HTTP status codes which are considered to be an error (alongside non-JSON)
      # responses
      ERROR_STATUSES = 400..599

      # @param env The Faraday environment, providing access to the response
      # @raise [Errors::ApiError] if the response from the Starling Bank API indicates an
      #                           error
      # @return [nil] if the response from the Starling Bank API doesn't indicate an
      #               error
      def on_complete(env)
        return unless ERROR_STATUSES.include?(env.status)
        raise Errors::ApiError, env
      end
    end
  end
end

Faraday::Response.register_middleware(
  raise_starling_errors: Starling::Middlewares::RaiseStarlingErrors
)
