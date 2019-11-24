class AreasController < ApplicationController
  def index
    render json: areas
  end

  private

  def areas
    Areas::List.call
  end
end
