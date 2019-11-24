require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let(:location) { create(:location) }

  describe '#show' do
    let(:expected_response) do
      {
        id: location.id,
        name: location.name,
        coordinates: {
          lat: location.lat,
          lng: location.lng
        },
        inside?: true
      }.to_json
    end

    before do
      allow(Locations::DetermineIsInsideAreas).to receive(:call).with(location).and_return(true)
    end

    subject { get :show, params: { id: location.id } }

    it 'returns location' do
      subject
      expect(response.body).to eq(expected_response)
    end
  end

  describe '#post' do
    let(:location) { create(:location) }
    let(:expected_response) { { id: location.id }.to_json }

    before do
      allow(Locations::Create).to receive(:call).with(an_instance_of(ActionController::Parameters)).and_return(form)
    end

    subject { post :create, params: { name: 'Sample location' } }

    context 'when params are valid' do
      let(:form) { instance_double(Locations::CreateForm, model: location, errors: []) }

      it 'returns location id' do
        subject
        expect(response.status).to eq(201)
        expect(response.body).to eq(expected_response)
      end
    end

    context 'when params are invalid' do
      let(:errors) { double(empty?: false, messages: instance_double(Hash)) }
      let(:form) { instance_double(Locations::CreateForm, model: location, errors: errors) }

      it 'returns 422' do
        subject
        expect(response.status).to eq(422)
      end
    end
  end
end
