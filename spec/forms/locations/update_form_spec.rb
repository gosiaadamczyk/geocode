require 'rails_helper'

module Locations
  RSpec.describe UpdateForm, type: :form do
    let(:location) { Location.new }
    let(:params) do
      {
          lat: 51.1078852,
          lng: 17.0385376
      }
    end

    subject { described_class.new(location) }

    describe '#validate' do
      it 'returns no errors' do
        expect(subject.validate(params)).to eq(true)
        expect(subject.errors).to be_empty
      end

      context 'with invalid params' do
        it 'validates presence of params' do
          expect(subject.validate({})).to eq(false)
          expect(subject.errors.keys).to eq([:lat, :lng])
        end
      end
    end
  end
end
