module Locations
  class DetermineIsInsideAreas < BaseService
    def initialize(location)
      @location = location
    end

    def call
      areas['features'].any? do |area|
        Locations::IsInsideArea.call(location, area)
      end
    end

    private

    attr_reader :location

    def areas
      Areas::List.call
    end
  end
end
