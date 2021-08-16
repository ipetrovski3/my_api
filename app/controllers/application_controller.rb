# frozen_string_literal: true

class ApplicationController < ActionController::API
  helper_method :set_distance
  include DeviseTokenAuth::Concerns::SetUserByToken


  def set_distance(user, farm)
    Google::Maps.distance_matrix(user.address, farm.address).distance / 1000
  end
end
