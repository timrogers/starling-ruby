lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'starling/version'

Gem::Specification.new do |spec|
  spec.name          = 'starling-ruby'
  spec.version       = Starling::VERSION
  spec.authors       = ['Tim Rogers']
  spec.email         = ['tim@gocardless.com']

  spec.summary       = 'A gem for interfacing with the Starling Bank API'
  spec.homepage      = 'https://github.com/timrogers/starling-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.2.0'

  spec.add_dependency 'faraday', '>= 0.8.9', '< 0.16'

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'reek', '~> 4.8.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.2.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.0'
  spec.add_development_dependency 'rubocop', '~> 0.57.0'
  spec.add_development_dependency 'values', '~> 1.8.0'
  spec.add_development_dependency 'webmock', '~> 3.4.0'
  spec.add_development_dependency 'yard', '~> 0.9.10'
end
