module LatestStockPrice
  class Price
    API_BASE_URL = "https://latest-stock-price.p.rapidapi.com/equities-search"

    def self.fetch(search_term) # Param example - "AAATECH.NS"
      raise ArgumentError, "Search term cannot be nil or empty" if search_term.nil? || search_term.strip.empty?

      encoded_term = URI.encode_www_form_component(search_term)
      uri = URI("#{API_BASE_URL}?Search=#{encoded_term}")
			LatestStockPrice::HttpClient.make_request(uri)
    end
  end
end
