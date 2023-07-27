# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherApi::Clients::WeatherApiClient, type: :weather_api_client do
  it 'raises error if api is not configured' do
    expect do
      described_class.new
    end.to raise_error(RuntimeError, 'API key must be set')
  end

  it 'raises error if base_url is not configured' do
    expect do
      described_class.new(api_key: 'some-key', base_url: nil)
    end.to raise_error(RuntimeError, 'API base url must be set')
  end

  it "doesn't print api_key mistakenly in the inspection" do
    subject = described_class.new(api_key: 'some-secret-key')
    expect(subject.inspect).not_to include('some-secret-key')
  end

  it 'calls HTTP get request with correct payload' do
    mock_response = instance_double(WeatherApi::HttpClient::Response, unauthorized?: false)
    mock_http_client = class_double(WeatherApi::HttpClient, get: mock_response)
    api_client = described_class.new(api_key: 'some-secret-key', http_client: mock_http_client)
    address = 'Milton, Canada, L9T5J7'

    query_params = {
      days: 1,
      key: 'some-secret-key',
      q: address
    }

    api_client.fetch_weather_report(address:)

    expect(mock_http_client).to have_received(:get).with(URI(described_class::BASE_URL), query_params)
  end

  context 'when response is successful' do
    subject(:api_client) do
      mock_response = instance_double(WeatherApi::HttpClient::Response, unauthorized?: false, body: 'I am the body')
      mock_http_client = class_double(WeatherApi::HttpClient, get: mock_response)
      described_class.new(api_key: 'some-secret-key', http_client: mock_http_client)
    end

    it 'returns forecasted weather report from WeatherApi' do
      actual_response = api_client.fetch_weather_report(address: 'Milton, Canada, L9T5J7')
      expect(actual_response.body).to eq('I am the body')
    end
  end

  context 'when response is forbidden' do
    subject(:api_client) do
      mock_response = instance_double(WeatherApi::HttpClient::Response, unauthorized?: true)
      mock_http_client = class_double(WeatherApi::HttpClient, get: mock_response)
      described_class.new(api_key: 'some-secret-key', http_client: mock_http_client)
    end

    it 'raises an error' do
      expect do
        api_client.fetch_weather_report(address: 'Milton, Canada, L9T5J7')
      end.to raise_error(described_class::InvalidApiKeyError,
                         'API key is incorrect, please verify the key has permission to access the API')
    end
  end
end
