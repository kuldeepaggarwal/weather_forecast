# frozen_string_literal: true

require 'net/http'

module WeatherApi
  # This class will be responsible to make GET API calls to any 3rd party APIs.
  #
  class HttpClient
    # This class will be an interface between `Net::HTTPResponse` and WeatherApi clients
    # and all the clients can rely on this object instead of underlying raw http response.
    #
    # We chose this approach to remove the dependency of `Net::HTTPResponse` in all the
    # WeatherApi clients. We can later move from Net::Http -> Faraday or some other
    # library w/o even changing any code in WeatherApi clients.
    #
    class Response
      attr_reader :status_code, :body

      def initialize(raw_response)
        @status_code = raw_response.code.to_i
        @body = success? ? JSON(raw_response.body) : raw_response.body
      end

      def success?
        status_code.between?(200, 399)
      end

      def unauthorized?
        status_code == 403
      end
    end

    class << self
      def get(uri, query_params = nil)
        uri.query = query_params.to_query if query_params
        request = build_request(Net::HTTP::Get, uri)
        send_request(request, uri)
      end

      private

      def send_request(request, uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme == 'https'
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER if http.use_ssl?

        response = http.start do
          http.request(request)
        end

        Response.new(response)
      end

      def build_request(req_class, uri)
        req_class.new(uri).tap do |request|
          request['Content-Type'] = 'application/json'
          request['Accept'] = 'application/json'
        end
      end
    end
  end
end
