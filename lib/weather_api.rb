# frozen_string_literal: true

require_relative 'weather_api/errors'

module WeatherApi
  # This is the public interface to fetch Weather report from any weather report provider.
  #
  # Currently, we only support WeatherAPI service provider but it can easily be extendible.
  def self.fetch_weather_report(client = Clients::WeatherApiClient.new, *, **)
    client.fetch_weather_report(*, **)
  end
end
