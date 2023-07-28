# frozen_string_literal: true

# This holds all the errors raised by the WeatherApi library
module WeatherApi
  class Errors < StandardError; end
  class InvalidApiKeyError < Errors; end
end
