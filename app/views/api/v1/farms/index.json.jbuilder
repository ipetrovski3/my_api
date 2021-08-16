# frozen_string_literal: true

json.array! @farms do |farm|
  json.size farm.size
  json.user farm.user.name if farm.user.name.present?
  json.address farm.address
  json.id farm.id
  json.yield farm.farm_yield
  json.driving_distance set_distance(current_api_v1_user, farm)
end

# json.array! @farms, :id, :address
