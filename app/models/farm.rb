# frozen_string_literal: true

class Farm < ApplicationRecord
  belongs_to :user

  before_save :set_longitude_and_latitude
  before_save :set_outliers
  after_save :update_outliers

  validates :address, presence: true
  validates :size, presence: true
  validates :farm_yield, presence: true

  scope :with_user, -> { includes(:user) }


private

  def set_longitude_and_latitude
    address = Google::Maps.geocode(self.address).first
    self.longtitude = address.longitude
    self.latitude = address.latitude
  end

  def average_yield
    all_yields = Farm.all.pluck(:farm_yield)
    all_yields.sum / all_yields.count if Farm.count > 1
  end

  def percent_of_average
    average_yield * 0.7 if average_yield.present?
  end

  def set_outliers
    average = percent_of_average || 0
    self.outliers = true if farm_yield < average
  end

  def update_outliers
    Farm.where('farm_yield < ?', percent_of_average).update_all(outliers: true)
    Farm.where('farm_yield > ?', percent_of_average).update_all(outliers: false)
  end
end
