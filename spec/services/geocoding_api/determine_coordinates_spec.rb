require 'rails_helper'

module GeocodingApi
  RSpec.describe DetermineCoordinates do
    let(:name) { 'Amphitheatre Parkway' }
    let(:url) { 'https://maps.googleapis.com/maps/api/geocode/json' }
    let(:api_key) { Rails.configuration.x.geocoding_api['api_key'] }
    let(:uri) { URI.parse("#{url}?address=#{name}&key=#{api_key}") }
    let(:coordinates) do
      {
        'lat' => 40.7142484,
        'lng' => -73.9614103
      }
    end
    let(:status) { 'OK' }
    let(:body) do
      {
        'status' => status,
        'results' => [
          {
            'geometry' => {
              'location' => coordinates
            }
          }
        ]
      }.to_json
    end
    let(:response) { instance_double(Net::HTTPResponse, code: '200', body: body) }

    before do
      allow(Net::HTTP).to receive(:get_response).with(uri).and_return(response)
    end

    subject { described_class.call(name) }

    context 'when response from Geocoding API is successful' do
      before do
        allow(VerifyResponse).to receive(:call).with(status).and_return(true)
      end

      it 'returns coordinates' do
        expect(subject).to eq(coordinates)
      end
    end

    context 'when response from Geocoding API is failure' do
      let(:status) { 'REQUEST_DENIED' }

      before do
        allow(VerifyResponse).to receive(:call).with(status).and_return(nil)
      end

      it 'returns coordinates' do
        expect(subject).to eq(nil)
      end
    end
  end
end
