module Starling
  class Utils
    class << self
      # @return [String] The gem's name and version
      def gem_info
        return 'starling-ruby' unless defined?(Starling::VERSION)
        "starling-ruby/v#{Starling::VERSION}"
      end

      # @return [String] The Ruby engine this code is currently running on
      def ruby_engine
        defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'ruby'
      end

      # @return [String] The Ruby version and patchlevel this code is currently running
      #                  on
      def ruby_version
        return RUBY_VERSION unless defined?(RUBY_PATCHLEVEL)
        RUBY_VERSION + "p#{RUBY_PATCHLEVEL}"
      end

      # @return [String] The JRuby interpreter version this code is currently running on,
      #                  or the Ruby version for non-JRuby environments
      def interpreter_version
        defined?(JRUBY_VERSION) ? JRUBY_VERSION : RUBY_VERSION
      end
    end
  end
end
