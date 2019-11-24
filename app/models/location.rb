class Location < ApplicationRecord
  def inside?
    Rails.cache.fetch("locations_inside/#{id}") do
      Locations::DetermineIsInsideAreas.call(self) if lat && lng
    end
  end
end
