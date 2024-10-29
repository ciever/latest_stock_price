require 'uri'
require 'net/http'
require 'json'

module LatestStockPrice
  class HttpClient
    def self.make_request(uri)
      response = perform_request(uri)
      parse_response(response.body)
    end

    private

    def self.perform_request(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request["x-rapidapi-key"] = ENV['X_RAPIDAPI_KEY']
      request["x-rapidapi-host"] = ENV['X_RAPIDAPI_HOST']
      response = http.request(request)

      unless response.is_a?(Net::HTTPSuccess)
        raise "Error fetching data: #{response.code} #{response.message}"
      end

      response
    rescue SocketError, Errno::ECONNREFUSED => e
      raise "Network error: #{e.message}"
    end

    def self.parse_response(response_body)
      JSON.parse(response_body)
    rescue JSON::ParserError => e
      raise "Error parsing response: #{e.message}"
    end
  end
end
