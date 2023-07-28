# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Display of Weather', type: :feature do
  around do |example|
    ClimateControl.modify(WEATHER_API_ACCESS_ID: 'somekey-for-testing') do
      example.run
    end
  end

  it 'raises runtime error whem api key is not setup' do
    visit root_path

    ClimateControl.modify WEATHER_API_ACCESS_ID: nil do
      expect { click_on 'Show Weather' }.to raise_error(RuntimeError, 'API key must be set')
    end
  end

  it 'raises invalid key error when api key does not have permission' do
    visit root_path

    ClimateControl.modify WEATHER_API_ACCESS_ID: 'some fake key value' do
      VCR.use_cassette('incorrect_key_error') do
        expect do
          click_on 'Show Weather'
        end.to raise_error(WeatherApi::InvalidApiKeyError,
                           'API key is incorrect, please verify the key has permission to access the API')
      end
    end
  end

  it 'shows current weather for a specified location' do
    VCR.use_cassette('berlin_germany_weather') do
      show_berlin_weather

      expect(page.body).to include("Today's weather is 18.0 °C.")
    end
  end

  it 'shows current weather for a specified location from cache', enable_cache: true do
    VCR.use_cassette('berlin_germany_weather') do
      show_berlin_weather # this will generate the cache
    end

    show_berlin_weather
    expect(page.body).to include("Today's weather is 18.0 °C.(cached)")
  end

  it 'shows not weather report message when location is not seleceted' do
    VCR.use_cassette('empty_location_weather') do
      visit root_path

      click_on 'Show Weather'
      expect(page.body).to include('No weather report found for the location!')
    end
  end

  it 'shows not weather report message when an invalid location is seleceted' do
    VCR.use_cassette('invalid_location_weather') do
      visit root_path

      fill_in :address_city, with: 'dasdhaskduhasukjdas dughasdbkn'
      click_on 'Show Weather'

      expect(page.body).to include('No weather report found for the location!')
    end
  end

  private

  def show_berlin_weather
    visit root_path

    fill_in :address_city, with: 'Berlin'
    fill_in :address_country, with: 'Germany'
    fill_in :address_zip_code, with: '13129'
    click_on 'Show Weather'
  end
end
