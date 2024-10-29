module LatestStockPrice
  class Prices
    API_BASE_URL = "https://latest-stock-price.p.rapidapi.com/equities-enhanced"

    def self.fetch(symbols) # Param example - ['AAATECH.NS', 'AADHHOUS.NS']
      raise ArgumentError, "Search term cannot be nil or empty" if symbols.nil? || symbols.empty? # could improve by checking each array item

			symbols_param = URI.encode_www_form_component(symbols.join(','))
      uri = URI("#{API_BASE_URL}?Symbols=#{symbols_param}")
			LatestStockPrice::HttpClient.make_request(uri)
    end
  end
end
