require 'bundler/setup'
require 'webmock/rspec'
require 'rspec/its'
require 'pry'
require 'values'
require 'starling'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.color = true
  config.order = :rand
  # config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
end

def load_fixture(*path)
  File.read(File.join('spec', 'fixtures', File.join(*path)))
end
