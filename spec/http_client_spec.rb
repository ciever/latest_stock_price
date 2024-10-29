require 'spec_helper'
require 'webmock/rspec'
require './lib/latest_stock_price/http_client'

RSpec.describe LatestStockPrice::HttpClient do
  let(:uri) { URI('https://latest-stock-price.p.rapidapi.com/test') }
  let(:valid_response) { { "key" => "value" }.to_json }
  
  before do
    ENV['X_RAPIDAPI_KEY'] = 'dummy_key'
    ENV['X_RAPIDAPI_HOST'] = 'dummy_host'
  end

  describe '.make_request' do
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
        response = described_class.make_request(uri)
        expect(response).to eq({"key" => "value"})
      end
    end

    context 'when the request fails' do
      before do
        stub_request(:get, uri).to_return(status: 404, body: "")
      end

      it 'raises an error' do
        expect { described_class.make_request(uri) }.to raise_error(RuntimeError, /Error fetching data: 404/)
      end
    end

    context 'when there is a network error' do
      before do
        allow(Net::HTTP).to receive(:new).and_raise(SocketError.new('Network issue'))
      end

      it 'raises a network error' do
        expect { described_class.make_request(uri) }.to raise_error(RuntimeError, /Network error: Network issue/)
      end
    end

    context 'when the response cannot be parsed' do
        before do
          stub_request(:get, uri).to_return(status: 200, body: 'invalid json')
        end
      
        it 'raises a parsing error' do
          expect { described_class.make_request(uri) }.to raise_error(RuntimeError, /Error parsing response: .*/)
        end
      end
  end
end
