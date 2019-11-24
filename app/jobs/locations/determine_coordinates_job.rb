module Locations
  class DetermineCoordinatesJob < ApplicationJob
    queue_as :locations

    def perform(location)
      Locations::Update.call(location, coordinates(location)) if coordinates(location)
    end

    private

    def coordinates(location)
      @coordinates ||= GeocodingApi::DetermineCoordinates.call(location.name)
    end
  end
end
