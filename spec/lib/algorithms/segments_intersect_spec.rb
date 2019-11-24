require 'rails_helper'

RSpec.describe SegmentsIntersect do
  subject { described_class.call(point_1, point_2, point_3, point_4) }

  context 'when segments intersect' do
    let(:point_1) { Point.new(x: 1, y: 2) }
    let(:point_2) { Point.new(x: 3, y: 1) }
    let(:point_3) { Point.new(x: 2, y: 1) }
    let(:point_4) { Point.new(x: 2, y: 4) }

    it 'returns true' do
      expect(subject).to be(true)
    end
  end

  context 'when segments intersect with collinear points' do
    let(:point_1) { Point.new(x: 1, y: 2) }
    let(:point_2) { Point.new(x: 3, y: 1) }
    let(:point_3) { Point.new(x: 3, y: 1)  }
    let(:point_4) { Point.new(x: 5, y: 2) }

    it 'returns true' do
      expect(subject).to be(true)
    end
  end

  context 'when segments do not intersect' do
    let(:point_1) { Point.new(x: 1, y: 2) }
    let(:point_2) { Point.new(x: 3, y: 1) }
    let(:point_3) { Point.new(x: 3, y: 3) }
    let(:point_4) { Point.new(x: 6, y: 3) }

    it 'returns false' do
      expect(subject).to be(false)
    end
  end
end
