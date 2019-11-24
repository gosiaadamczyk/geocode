module Locations
  class Create < BaseService
    def initialize(params)
      @params = params
    end

    def call
      determine_coordinates if form.validate(params) && form.save

      form
    end

    private

    attr_reader :params

    def form
      @form ||= Locations::CreateForm.new(location)
    end

    def location
      Location.new
    end

    def determine_coordinates
      Locations::DetermineCoordinatesJob.perform_later(form.model)
    end
  end
end
