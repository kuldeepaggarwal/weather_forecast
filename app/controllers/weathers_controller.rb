# frozen_string_literal: true

class WeathersController < ApplicationController
  def index; end

  def search
    location = params.require(:address).slice('city', 'state', 'country', 'zip_code')
    address = location.values_at('city', 'state', 'country', 'zip_code').map(&:presence).compact
    response = WeatherApi.fetch_weather_report(address: address.join(' '))

    weather_component =
      if response.success?
        WeatherComponent.new(report: WeatherForecastApiFormatter.format(response.body))
      else
        NoWeatherComponent.new
      end

    render(turbo_stream: turbo_stream.update('weather-report', weather_component))
  end
end
