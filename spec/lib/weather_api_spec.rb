# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherApi do
  describe '.fetch_weather_report' do
    it 'fetches the weather report from the client' do
      client = instance_double(WeatherApi::Clients::WeatherApiClient, fetch_weather_report: nil)

      described_class.fetch_weather_report(client, address: 'hello')

      expect(client).to have_received(:fetch_weather_report).with(address: 'hello')
    end
  end
end
