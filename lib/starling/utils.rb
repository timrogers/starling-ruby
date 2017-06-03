module Starling
  class Utils
    class << self
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
end
