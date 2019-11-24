module Locations
  class Update < BaseService
    def initialize(location, params)
      @location = location
      @params = params
    end

    def call
      form.validate(params) && form.save
      form
    end

    private

    attr_reader :location, :params

    def form
      @form ||= Locations::UpdateForm.new(location)
    end
  end
end
