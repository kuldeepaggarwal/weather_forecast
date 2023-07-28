# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'bootsnap', '~> 1.16.0'
gem 'importmap-rails', '~> 1.2.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'
gem 'sprockets-rails', '~> 3.4.2'
gem 'stimulus-rails', '~> 1.2.1'
gem 'turbo-rails', '~> 1.4.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'view_component', '~> 3.5.0'

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 6.0.3'
  gem 'rubocop', '~> 1.55.0', require: false
  gem 'rubocop-rails', '~> 2.20.2', require: false
  gem 'rubocop-rspec', '~> 2.22.0', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.8.0'
  gem 'web-console', '~> 4.2.0'
end

group :test do
  gem 'capybara', '~> 3.39.2'
  gem 'climate_control'
  gem 'simplecov', '~> 0.22.0', require: false
  gem 'vcr'
  gem 'webmock', '~> 3.18.1'
end
