# frozen_string_literal: true

module WeatherApi
  module Clients
    # This class is one of the clients to fetch weather forecast reports from the WeatherApi APIs.
    #
    # This class is developed based on the adapter pattern where multiple Client may exist in the future
    # and the caller will decide from which weather reports provider we need to fetch the information.
    #
    class WeatherApiClient
      BASE_URL = 'https://api.weatherapi.com/v1/forecast.json'

      def initialize(
        api_key: ENV.fetch('WEATHER_API_ACCESS_ID', nil),
        base_url: BASE_URL,
        http_client: WeatherApi::HttpClient
      )

        raise 'API key must be set' if api_key.blank?
        raise 'API base url must be set' if base_url.blank?

        @base_url = base_url
        @api_key = api_key
        @http_client = http_client
      end

      def inspect
        "#<WeatherApiClient api_key:'XXXXXXX', base_url: #{@base_url.inspect}>"
      end
      alias to_s inspect

      def fetch_weather_report(address:, forcast_days: 1)
        query_params = { q: address, days: forcast_days, key: @api_key }

        response = @http_client.get(URI(@base_url), query_params)

        if response.unauthorized?
          raise WeatherApi::InvalidApiKeyError,
                'API key is incorrect, please verify the key has permission to access the API'
        end

        response
      end
    end
  end
end
