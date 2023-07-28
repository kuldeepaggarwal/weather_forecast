# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherForecastApiFormatter, type: :formatter do
  describe '.format' do
    it 'returns Business domain Weather report object' do
      weather_response = {
        'location' => {
          'name' => 'Delhi',
          'region' => 'Delhi',
          'country' => 'India',
          'lat' => 28.67,
          'lon' => 77.22,
          'tz_id' => 'Asia/Kolkata',
          'localtime_epoch' => 1_690_566_173,
          'localtime' => '2023-07-28 23:12'
        },
        'current' => {
          'last_updated_epoch' => 1_690_565_400,
          'last_updated' => '2023-07-28 23:00',
          'temp_c' => 26.0,
          'temp_f' => 78.8,
          'is_day' => 0
        }
      }
      expected_report = WeatherReport.new(
        current: Weather.new(
          updated_at: Time.parse('2023-07-28T17:30:00Z'),
          temperature_in_celcius: 26.0,
          temperature_in_fahrenheit: 78.8
        )
      )
      expect(described_class.format(weather_response)).to eq(expected_report)
    end
  end
end
