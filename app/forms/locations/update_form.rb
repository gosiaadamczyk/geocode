module Locations
  class UpdateForm < BaseForm
    model :location

    properties :lat, :lng

    validates :lat, :lng, presence: true
  end
end
