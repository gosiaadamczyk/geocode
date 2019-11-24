require 'rails_helper'

module GeocodingApi
  RSpec.describe VerifyResponse do
    let(:status) { 'OK' }

    subject { described_class.call(status) }

    context 'when status is OK' do
      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when status is failure' do
      let(:status) { 'REQUEST_DENIED' }

      it 'returns coordinates' do
        expect(subject).to eq(nil)
      end
    end
  end
end
