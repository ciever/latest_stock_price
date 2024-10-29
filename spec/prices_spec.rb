require 'spec_helper'
require 'webmock/rspec'
require './lib/latest_stock_price/prices'

RSpec.describe LatestStockPrice::Prices do
  let(:symbols) { ['AAATECH.NS', 'AADHHOUS.NS'] }
  let(:uri) { URI("https://latest-stock-price.p.rapidapi.com/equities-enhanced?Symbols=#{URI.encode_www_form_component(symbols.join(','))}") }
  let(:valid_response) { { "key" => "value" }.to_json }

  before do
    ENV['X_RAPIDAPI_KEY'] = 'dummy_key'
    ENV['X_RAPIDAPI_HOST'] = 'dummy_host'
  end

  describe '.fetch' do
    context 'when symbols are valid' do
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
        response = described_class.fetch(symbols)
        expect(response).to eq({"key" => "value"})
      end
    end

    context 'when symbols are nil or empty' do
      it 'raises an ArgumentError' do
        expect { described_class.fetch(nil) }.to raise_error(ArgumentError, /Search term cannot be nil or empty/)
        expect { described_class.fetch([]) }.to raise_error(ArgumentError, /Search term cannot be nil or empty/)
      end
    end
  end
end
