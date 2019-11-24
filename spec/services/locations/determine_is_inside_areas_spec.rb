require 'rails_helper'

module Locations
  RSpec.describe DetermineIsInsideAreas, type: :service do
    let(:location) { instance_double(Location) }
    let(:area) { instance_double(Hash) }
    let(:areas) { { 'features' => [area] } }

    subject { described_class.call(location) }

    before do
      allow(Areas::List).to receive(:call).and_return(areas)
    end

    context 'when location is inside one area' do
      before do
        allow(Locations::IsInsideArea).to receive(:call).with(location, area).and_return(true)
      end

      it 'returns true' do
        expect(subject).to be(true)
      end
    end

    context 'when location is not included in any area' do
      before do
        allow(Locations::IsInsideArea).to receive(:call).with(location, area).and_return(false)
      end

      it 'returns false' do
        expect(subject).to be(false)
      end
    end
  end
end
