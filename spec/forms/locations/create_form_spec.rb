require 'rails_helper'

module Locations
  RSpec.describe CreateForm, type: :form do
    let(:location) { Location.new }
    let(:params) { { name: 'Location' } }

    subject { described_class.new(location) }

    describe '#validate' do
      it 'returns no errors' do
        expect(subject.validate(params)).to eq(true)
        expect(subject.errors).to be_empty
      end

      context 'with invalid params' do
        it 'validates presence of params' do
          expect(subject.validate({})).to eq(false)
          expect(subject.errors.keys).to eq([:name])
        end
      end
    end
  end
end
