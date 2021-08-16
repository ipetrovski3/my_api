# frozen_string_literal: true

class FarmSortingQuery
  attr_reader :user

  def initialize(options, user)
    @options = options
    @user = user
  end

  def call
    farms = Farm.with_user
    if @options[:size].present?
      farms.order(size: @options[:size])
    elsif @options[:farm_yield].present?
      farms.order(farm_yield: @options[:farm_yield])
    elsif @options[:distance].present? && @options[:distance] === 'nearest'
      farms_with_distance.sort_by { |farm| farm[:distance] }
    elsif @options[:outliers].present?
      farms.where(outliers: true)
    else
      farms
    end
  end

private

  def farms_with_distance
    Farm.with_user.map do |farm|
      farm.distance = set_distance(user, farm) / 1000
      farm
    end
  end

  def set_distance(user, farm)
    Google::Maps.distance_matrix(user.address, farm.address).distance
  end
end
