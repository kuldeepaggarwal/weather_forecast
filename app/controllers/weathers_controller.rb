# frozen_string_literal: true

class WeathersController < ApplicationController
  def index; end

  # rubocop:disable Metrics/AbcSize
  def search
    address = params.require(:address)
                    .permit('city', 'state', 'country', 'zip_code')
                    .to_h.filter_map { |(_, v)| v.presence }.join(' ')

    # Here, the requirement was to cache the report by zip_code; however, we can search by other attributes
    # too. So, in order to have consistency for caching and save API calls, I am caching the api response for
    # the whole address.
    cached = Rails.cache.exist?(address)
    response = Rails.cache.fetch(address, expires_in: 30.minutes) { WeatherApi.fetch_weather_report(address:) }

    weather_component =
      if response.success?
        WeatherComponent.new(report: WeatherForecastApiFormatter.format(response.body), cached:)
      else
        NoWeatherComponent.new
      end

    render(turbo_stream: turbo_stream.update('weather-report', weather_component))
  end
  # rubocop:enable Metrics/AbcSize
end
