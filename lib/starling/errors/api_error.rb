require 'json'

module Starling
  module Errors
    class ApiError < BaseError
      def message
        return super unless json?
        return super if error.nil? || error_description.nil?

        "#{status}: #{error_description} (#{error})"
      end
    end
  end
end
