# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherComponent, type: :component do
  let(:current_weather) do
    Weather.new(
      temperature_in_fahrenheit: 122.1,
      temperature_in_celcius: 12,
      updated_at: Time.parse('2027-07-21T20:30:00Z')
    )
  end
  let(:report) { WeatherReport.new(current: current_weather) }

  it 'renders current weather information' do
    render_inline(described_class.new(report:))

    expect(page).to have_content("Today's weather is 12 °C.")
  end

  it 'renders current weather information in Farenheit' do
    render_inline(described_class.new(report:, preference_unit: :farenheit))

    expect(page).to have_content("Today's weather is 122.1 °F.")
  end
end
