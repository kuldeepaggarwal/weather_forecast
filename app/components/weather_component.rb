# frozen_string_literal: true

class WeatherComponent < ViewComponent::Base
  SUPPORTED_WEATHER_UNITS = %i[celcius farenheit].freeze

  def initialize(report:, preference_unit: :celcius)
    super()
    raise 'Preference unit can either be :celcius or :farenheit' if SUPPORTED_WEATHER_UNITS.exclude?(preference_unit)

    @preference_unit = preference_unit
    @report = report
  end

  def current_temperature
    if @preference_unit == :celcius
      "#{@report.current.temperature_in_celcius} °C"
    else
      "#{@report.current.temperature_in_fahrenheit} °F"
    end
  end
end
