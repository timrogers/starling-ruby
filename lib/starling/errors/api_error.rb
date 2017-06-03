require 'json'

module Starling
  module Errors
    class ApiError < BaseError
      def message
        return super unless json?
        return super unless error && error_description

        "#{status}: #{error_description} (#{error})"
      end
    end
  end
end
