module Locations
  class IsInsideArea < BaseService
    def initialize(location, area)
      @location = location
      @area = area
      @intersections = 0
    end

    def call
      coordinates.each_cons(2) do |coords_1, coords_2|
        point_1 = coords_to_point(coords_1)
        point_2 = coords_to_point(coords_2)
        @intersections += 1 if intersects?(point_1, point_2)
      end

      intersections.odd?
    end

    private

    attr_reader :location, :area, :intersections

    def coordinates
      @coordinates ||= area['geometry']['coordinates'][0]
    end

    def coords_to_point(coords)
      Point.new(x: coords[0], y: coords[1])
    end

    def intersects?(point_1, point_2)
      SegmentsIntersect.call(location_point, point_on_half_straight, point_1, point_2)
    end

    def location_point
      @location_point ||= Point.new(x: location.lng, y: location.lat)
    end

    def point_on_half_straight
      @point_on_half_straight ||= Point.new(x: max_lng_area + 1, y: location.lat)
    end

    def max_lng_area
      @max_lng_area ||= area['geometry']['coordinates'][0].map(&:first).max
    end
  end
end
