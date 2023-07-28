# frozen_string_literal: true

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir     = 'spec/cassettes'
  c.default_cassette_options = { record: :new_episodes }
  c.hook_into :webmock
  c.filter_sensitive_data('<WEATHER_API_ACCESS_ID>') { ENV.fetch('WEATHER_API_ACCESS_ID', nil) }
end
