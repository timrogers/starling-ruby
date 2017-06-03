module Starling
  class Request
    # @param connection [Faraday] A Faraday connection
    # @param method [Symbol] The HTTP method for the request
    # @param path [String] The path of the API endpoint, which will be added to the
    #                      base URL (from {Starling::Client::ENVIRONMENT_BASE_URLS}) and
    #                      the API version-specific base path ({ApiService::BASE_PATH})
    # @param params [Hash] The parameters which will be included in the request, either
    #                      in the URL or the body, depending on the method
    # @param headers [Hash] The headers to be included in the request
    def initialize(connection, method, path, params: {}, headers: {})
      @connection = connection
      @method = method
      @path = path
      @headers = headers
      @request_body = params if %i[post put delete].include?(method)
      @request_query = method == :get ? params : {}

      return unless @request_body.is_a?(Hash)
      @request_body = @request_body.to_json
      @headers['Content-Type'] ||= 'application/json'
    end

    # Dispatch the configured HTTP request
    #
    # @return [Faraday::Request] The response from the HTTP request
    def make_request
      @connection.send(@method) do |request|
        request.url @path
        request.body = @request_body
        request.params = @request_query
        request.headers.merge!(@headers)
      end
    end
  end
end
