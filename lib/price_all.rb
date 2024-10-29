module LatestStockPrice
  class PriceAll
    API_BASE_URL = "https://latest-stock-price.p.rapidapi.com/any"

    def self.fetch
			uri = URI(API_BASE_URL)
      LatestStockPrice::HttpClient.make_request(uri)
    end
  end
end
