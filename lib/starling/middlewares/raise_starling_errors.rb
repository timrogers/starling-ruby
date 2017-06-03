module Starling
  module Middlewares
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
        return unless !json?(env) && ERROR_STATUSES.include?(env.status)
        raise Errors::ApiError, env
      end

      private

      def json?(env)
        env.response_headers.fetch('Content-Type', '')
           .include?('application/json')
      end
    end
  end
end

Faraday::Response.register_middleware(
  raise_starling_errors: Starling::Middlewares::RaiseStarlingErrors
)
