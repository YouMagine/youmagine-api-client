require "./lib/youmagine-api-client"
require "vcr"

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

VCR.configure do |c|
  c.cassette_library_dir = "vcr_cassettes"
  c.hook_into :fakeweb
  c.default_cassette_options = { record: :once }
end

Youmagine.configure do |c|
  c.uri = "https://api.youmagine.com/v1/"
  c.token = "foobar"
end


