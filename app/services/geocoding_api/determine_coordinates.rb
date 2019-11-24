require 'net/http'

module GeocodingApi
  class DetermineCoordinates < BaseService
    def initialize(name)
      @name = name
    end

    def call
      make_request
      coordinates if verify_response
    end

    private

    attr_reader :name, :response

    def make_request
      @response = Net::HTTP.get_response(uri)
    rescue Errno::ECONNREFUSED, Net::ReadTimeout => e
      sleep(30)
      retry
    end

    def verify_response
      make_request_again if parsed_response['status'] == 'UNKNOWN_ERROR'
      VerifyResponse.call(parsed_response['status'])
    end

    def make_request_again
      sleep(30)
      make_request
    end

    def coordinates
      parsed_response['results'][0]['geometry']['location']
    end

    def parsed_response
      JSON.parse(response.body)
    end

    def url
      'https://maps.googleapis.com/maps/api/geocode/json'
    end

    def uri
      URI.parse("#{url}?address=#{name}&key=#{api_key}")
    end

    def api_key
      Rails.configuration.x.geocoding_api['api_key']
    end
  end
end
