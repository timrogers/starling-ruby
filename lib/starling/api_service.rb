require 'faraday'

module Starling
  # The API client under the hood, used by services publicly exposed by
  # {Starling::Client} to dispatch requests to the Starling Bank API
  class ApiService
    # The default adapter which will be used by Faraday to make requests. This can be
    # customised by passing a :http_adapter when instantiating the ApiService.
    DEFAULT_ADAPTER = :net_http

    # The path of the API version which will be prepended to request paths
    BASE_PATH = '/api/v1'.freeze

    # Instantiates a {ApiService} for dispatching requests to the Starling Bank API
    #
    # @param base_url [String] The base URL for the Starling API, including the protocol
    #                          and hostname, to which the {BASE_PATH} and request paths
    #                          will be added
    # @param access_token [String] A personal access token for the Starling Bank API
    # @param http_adapter [Array] The HTTP adapter to be used, defaulting to
    #                             {DEFAULT_ADAPTER}
    # @param connection_options [Hash] A hash of options to be passed in when
    #                                  instantiating Faraday (for example for setting
    #                                  the request timeout)
    # @param default_headers [Hash] A set of user-provided HTTP headers to add to each
    #                               request, alongside the library's defaults defined in
    #                               {#library_default_headers}
    # @return [Starling::ApiService] The configured ApiService
    def initialize(base_url, access_token:, http_adapter: [DEFAULT_ADAPTER],
                   connection_options: {}, default_headers: {})
      @connection = Faraday.new(base_url, connection_options) do |faraday|
        faraday.response(:raise_starling_errors)
        faraday.adapter(*http_adapter)
      end

      @headers = library_default_headers(access_token: access_token)
                 .merge(default_headers)
    end

    # Makes an HTTP request to the Starling Bank API with the specified method and path
    #
    # @param method [Symbol] The HTTP method which will be used for the request
    # @param path [String] The path of the API endpoint, which will be appended to the
    #                      {BASE_PATH}
    # @param params [Hash] The parameters which will be included in the request, either
    #                      in the URL or the body, depending on the method
    # @param headers [Hash] Additional headers to be included in your request, which will
    #                       be merged on top of the service's default headers
    # @return [Faraday::Response] The response from the server to the dispatched request
    def make_request(method, path, params: {}, headers: {})
      headers = @headers.merge(headers)

      Request.new(@connection, method, build_path(path), params: params,
                                                         headers: headers)
             .make_request
    end

    private

    def build_path(path)
      "#{BASE_PATH}#{path}"
    end

    def library_default_headers(access_token:)
      {
        'Authorization' => "Bearer #{access_token}",
        'Accept' => 'application/json',
        'User-Agent' => user_agent
      }
    end

    def user_agent
      @user_agent ||=
        begin
          comment = [
            "#{Utils.ruby_engine}/#{Utils.ruby_version}",
            "#{RUBY_ENGINE}/#{Utils.interpreter_version}",
            RUBY_PLATFORM.to_s,
            "faraday/#{Faraday::VERSION}"
          ]

          "#{Utils.gem_info} #{comment.join(' ')}"
        end
    end
  end
end
