# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:example, enable_cache: true) do
    allow(Rails).to receive(:cache).and_return(ActiveSupport::Cache::MemoryStore.new)
  end

  config.after(:example, enable_cache: true) do
    allow(Rails).to receive(:cache).and_call_original
  end
end
