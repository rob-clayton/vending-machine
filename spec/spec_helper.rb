# frozen_string_literal: true

# This file was generated by the `rspec --init` command.
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

# Starting Test Coverage:
require 'simplecov'
SimpleCov.start

require 'require_all'
require 'pry'

require_all 'lib'

RSpec.configure do |config|
  # rspec-expectations config goes here.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here.
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
