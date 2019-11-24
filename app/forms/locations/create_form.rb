module Locations
  class CreateForm < BaseForm
    model :location

    property :name

    validates :name, presence: true
  end
end
