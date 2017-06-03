module Starling
  # :reek:TooManyInstanceVariables
  class Request
    def initialize(connection, method, path, options)
      @connection = connection
      @method = method
      @path = path
      @headers = options.delete(:headers) || {}
      params = options.fetch(:params, {})
      @request_body = params if %i[post put delete].include?(method)
      @request_query = method == :get ? params : {}

      return unless @request_body.is_a?(Hash)
      @request_body = @request_body.to_json
      @headers['Content-Type'] ||= 'application/json'
    end

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
