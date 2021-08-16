# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :farms, dependent: :destroy

  before_save :set_longitude_and_latitude

private

  def set_longitude_and_latitude
    address = Google::Maps.geocode(self.address).first
    self.longitude = address.longitude
    self.latitude = address.latitude
  end
end
