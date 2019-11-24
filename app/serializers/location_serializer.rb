class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :coordinates, :inside?

  def coordinates
    {
      lat: object.lat,
      lng: object.lng
    }
  end
end
