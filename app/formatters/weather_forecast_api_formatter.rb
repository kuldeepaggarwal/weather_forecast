# frozen_string_literal: true

# This api response formatter is very specific to to format the response from WeatherAPI forecaset API.
#
# API: GET https://api.weatherapi.com/v1/forecast.json
class WeatherForecastApiFormatter
  class << self
    def format(weather_response)
      WeatherReport.new(
        current: build_current_weather(weather_response.fetch('current'))
      )
    end

    private

    def build_current_weather(current_weather_response)
      Weather.new(
        updated_at: Time.at(current_weather_response.fetch('last_updated_epoch')).utc,
        temperature_in_celcius: current_weather_response.fetch('temp_c'),
        temperature_in_fahrenheit: current_weather_response.fetch('temp_f')
      )
    end
  end
end
