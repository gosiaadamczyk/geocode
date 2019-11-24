require 'rails_helper'

module Locations
  RSpec.describe Update, type: :service do
    let(:params) { instance_double(Hash) }
    let(:location) { instance_double(Location) }
    let(:form) { instance_double(UpdateForm, model: location) }

    subject { described_class.call(location, params) }

    before do
      allow(UpdateForm).to receive(:new).with(location).and_return(form)
    end

    context 'when params are valid' do
      before do
        allow(form).to receive(:validate).with(params).and_return(true)
        allow(form).to receive(:save).and_return(true)
      end

      it 'saves location form' do
        expect(form).to receive(:save)
        subject
      end
    end

    context 'when params are invalid' do
      before do
        allow(form).to receive(:validate).with(params).and_return(false)
      end

      it 'does not save location form' do
        expect(form).not_to receive(:save)
        subject
      end
    end
  end
end
