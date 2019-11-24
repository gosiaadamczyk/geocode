require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  let(:location) { create(:location) }

  describe '#index' do
    let(:areas) do
      {
        "type" => "FeatureCollection",
        "features" => [
          {
            "type" => "Feature",
            "properties" => {},
            "geometry" => {
              "type" => "Polygon",
              "coordinates" => [
                [
                  [
                    7.36083984375,
                    50.666872321810715
                  ],
                  [
                    8.19580078125,
                    49.82380908513249
                  ],
                  [
                    10.634765625,
                    50.190967765585604
                  ],
                  [
                    7.36083984375,
                    50.666872321810715
                  ]
                ]
              ]
            }
          }
        ]
      }.to_json
    end

    before do
      allow(Areas::List).to receive(:call).and_return(areas)
    end

    subject { get :index }

    it 'returns areas' do
      subject
      expect(response.body).to eq(areas)
    end
  end
end
