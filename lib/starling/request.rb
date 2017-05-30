module Starling
  class Request
    def initialize(connection, method, path, options)
      @connection = connection
      @method = method
      @path = path
      @headers = options.delete(:headers) || {}
      @options = options
      @request_body = request_body
      @request_query = request_query

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

    private

    def request_body
      return @options.fetch(:params, {}) if %i[post put delete].include?(@method)

      nil
    end

    def request_query
      return @options.fetch(:params, {}) if @method == :get

      {}
    end
  end
end
