class LocationsController < ApplicationController
  def show
    render json: location, serializer: LocationSerializer
  end

  def create
    form = Locations::Create.call(params)

    if form.errors.empty?
      render json: form.model, serializer: LocationBasicDataSerializer, status: 201
    else
      render json: { errors: form.errors.messages }, status: 422
    end
  end

  private

  def location
    @location ||= Location.find(params[:id])
  end
end
