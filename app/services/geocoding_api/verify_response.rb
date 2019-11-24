module GeocodingApi
  class VerifyResponse < BaseService
    FAILURE_STATUSES = %w[OVER_DAILY_LIMIT OVER_QUERY_LIMIT REQUEST_DENIED UNKNOWN_ERROR].freeze

    def initialize(status)
      @status = status
    end

    def call
      return true if status == 'OK'

      notify_about_geocoding_api_failure if FAILURE_STATUSES.include?(status)
    end

    private

    attr_reader :status

    def notify_about_geocoding_api_failure
      # e-mail notification to support/admin
    end
  end
end
