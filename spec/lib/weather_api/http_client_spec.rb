# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherApi::HttpClient, type: :net_http_client do
  describe '.get' do
    before do
      stub_request(:get, 'https://google.com/ca?a=1')
        .with(
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'Host' => 'google.com',
            'User-Agent' => 'Ruby'
          }
        ).to_return(status: 200, body: %({"hello":1}), headers: {})
    end

    it 'sends Net::HTTP::Get request with correct query_params' do
      uri = URI('https://google.com/ca')
      query_params = { a: 1 }
      described_class.get(uri, query_params)

      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
      expect(WebMock).to have_requested(:get, uri.to_s).with(query: query_params, headers:)
    end

    it 'returns Response object' do
      uri = URI('https://google.com/ca')
      query_params = { a: 1 }
      response = described_class.get(uri, query_params)

      expect(response).to be_a(described_class::Response)
    end

    it 'returns correct response' do
      uri = URI('https://google.com/ca')
      query_params = { a: 1 }
      response = described_class.get(uri, query_params)

      expect(response.body).to eq({ 'hello' => 1 })
    end

    describe 'Response#unauthorized?' do
      let(:dummy_failed_response) { Struct.new(:code, :body).new(403, "You don't have permission") }

      it 'returns true when API returned forbidden response' do
        response = described_class::Response.new(dummy_failed_response)
        expect(response).to be_unauthorized
      end
    end
  end
end
