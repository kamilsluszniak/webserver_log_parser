# frozen_string_literal: true

require 'rspec'
require 'pry'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'webserver_log_parser'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
