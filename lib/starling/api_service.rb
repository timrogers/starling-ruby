require 'faraday'

module Starling
  class ApiService
    DEFAULT_ADAPTER = :net_http
    BASE_PATH = '/api/v1'.freeze

    def initialize(base_url, options = {})
      @access_token = options.fetch(:access_token)

      http_adapter = options[:http_adapter] || [DEFAULT_ADAPTER]
      connection_options = options[:connection_options]

      @connection = Faraday.new(base_url, connection_options) do |faraday|
        faraday.response(:raise_starling_errors)
        faraday.adapter(*http_adapter)
      end

      user_provided_default_headers = options.fetch(:default_headers, {})
      @headers = default_headers.merge(user_provided_default_headers)
    end

    def make_request(method, path, options = {})
      raise ArgumentError, 'options must be a hash' unless options.is_a?(Hash)
      options[:headers] ||= {}
      options[:headers] = @headers.merge(options[:headers])

      Request.new(@connection, method, build_path(path), options)
             .make_request
    end

    private

    def build_path(path)
      "#{BASE_PATH}#{path}"
    end

    def default_headers
      {
        'Authorization' => "Bearer #{@access_token}",
        'Accept' => 'application/json',
        'User-Agent' => user_agent
      }
    end

    def user_agent
      @user_agent ||=
        begin
          comment = [
            "#{ruby_engine}/#{ruby_version}",
            "#{RUBY_ENGINE}/#{interpreter_version}",
            RUBY_PLATFORM.to_s,
            "faraday/#{Faraday::VERSION}"
          ]

          "#{gem_info} #{comment.join(' ')}"
        end
    end

    def gem_info
      return 'starling-ruby' unless defined?(Starling::VERSION)
      "starling-ruby/v#{Starling::VERSION}"
    end

    def ruby_engine
      defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
    end

    def ruby_version
      return RUBY_VERSION unless defined?(RUBY_PATCHLEVEL)
      RUBY_VERSION + "p#{RUBY_PATCHLEVEL}"
    end

    def interpreter_version
      defined?(JRUBY_VERSION) ? JRUBY_VERSION : RUBY_VERSION
    end
  end
end
