require 'rails_helper'

module Locations
  RSpec.describe IsInsideArea, type: :service do
    let(:location) { instance_double(Location, lng: instance_double(Float), lat: instance_double(Float)) }
    let(:location_point) { Point.new(x: location.lng, y: location.lat) }
    let(:point_1) { instance_double(Point, x: 1, y: 2) }
    let(:point_2) { instance_double(Point, x: 3, y: 4) }
    let(:point_3) { instance_double(Point, x: 5, y: 6) }
    let(:point_on_half_straight) { instance_double(Point, x: 6, y: location.lat) }
    let(:area) do
      {
        'geometry' => {
          'coordinates' => [[
            [point_1.x, point_1.y],
            [point_2.x, point_2.y],
            [point_3.x, point_3.y],
            [point_1.x, point_1.y]
          ]]
        }
      }
    end

    subject { described_class.call(location, area) }

    before do
      allow(Point).to receive(:new).with(x: location.lng, y: location.lat).and_return(location_point)
      allow(Point).to receive(:new).with(x: 1, y: 2).and_return(point_1)
      allow(Point).to receive(:new).with(x: 3, y: 4).and_return(point_2)
      allow(Point).to receive(:new).with(x: 5, y: 6).and_return(point_3)
      allow(Point).to receive(:new).with(x: 6, y: location.lat).and_return(point_on_half_straight)
      allow(SegmentsIntersect).to receive(:call).with(location_point, point_on_half_straight, point_1, point_2).and_return(true)
      allow(SegmentsIntersect).to receive(:call).with(location_point, point_on_half_straight, point_2, point_3).and_return(true)
      allow(SegmentsIntersect).to receive(:call).with(location_point, point_on_half_straight, point_3, point_1).and_return(true)
    end

    context 'when the numbers of intersections are odd' do
      it 'returns true' do
        expect(subject).to be(true)
      end
    end

    context 'when the numbers of intersections are even' do
      before do
        allow(SegmentsIntersect).to receive(:call).with(location_point, point_on_half_straight, point_3, point_1).and_return(false)
      end

      it 'returns false' do
        expect(subject).to be(false)
      end
    end
  end
end
