require 'spec_helper'
require 'webmock/rspec'
require './lib/latest_stock_price/price_all'

RSpec.describe LatestStockPrice::PriceAll do
  let(:uri) { URI("https://latest-stock-price.p.rapidapi.com/any") }
  let(:valid_response) { { "key" => "value" }.to_json }

  before do
    ENV['X_RAPIDAPI_KEY'] = 'dummy_key'
    ENV['X_RAPIDAPI_HOST'] = 'dummy_host'
  end

  describe '.fetch' do
    context 'when the request is successful' do
      before do
        stub_request(:get, uri)
          .with(
            headers: {
              'x-rapidapi-key' => ENV['X_RAPIDAPI_KEY'],
              'x-rapidapi-host' => ENV['X_RAPIDAPI_HOST']
            }
          )
          .to_return(status: 200, body: valid_response)
      end

      it 'returns parsed JSON response' do
        response = described_class.fetch
        expect(response).to eq({"key" => "value"})
      end
    end

    context 'when the request fails' do
      before do
        stub_request(:get, uri).to_return(status: 404, body: "")
      end

      it 'raises an error' do
        expect { described_class.fetch }.to raise_error(RuntimeError, /Error fetching data: 404/)
      end
    end
  end
end
