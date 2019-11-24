module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
