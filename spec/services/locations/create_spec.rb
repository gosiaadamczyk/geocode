require 'rails_helper'

module Locations
  RSpec.describe Create, type: :service do
    let(:params) { instance_double(Hash) }
    let(:location) { instance_double(Location) }
    let(:form) { instance_double(CreateForm, model: location) }

    subject { described_class.call(params) }

    before do
      allow(Location).to receive(:new).and_return(location)
      allow(CreateForm).to receive(:new).with(location).and_return(form)
      allow(Locations::DetermineCoordinatesJob).to receive(:perform_later).with(form.model)
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

      it 'performs job to determine coordinates' do
        expect(Locations::DetermineCoordinatesJob).to receive(:perform_later).with(form.model)
        subject
      end
    end

    context 'when location params are invalid' do
      before do
        allow(form).to receive(:validate).with(params).and_return(false)
      end

      it 'does not save location form' do
        expect(form).not_to receive(:save)
        subject
      end

      it 'does not perform job' do
        expect(Locations::DetermineCoordinatesJob).not_to receive(:perform_later).with(form.model)
        subject
      end
    end
  end
end
