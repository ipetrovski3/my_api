# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  {
    email: 'test@test.com',
    password: 'password',
    password_confirmation: 'password',
    address: 'Skopje, Macedonia',
    name: 'Example User'
  },
  {
    email: 'other@test.com',
    password: 'password',
    password_confirmation: 'password',
    address: 'Amsterdam, Netherlands',
    name: 'Example User'
  }
]

users.each do |user|
  User.create!(user)
end


farms = [
  {
    address: 'Ohrid, Macedonia',
    size: rand(100..1000),
    farm_yield: 15,
    user_id: 1
  },
  {
    address: 'Tetovo, Macedonia',
    size: rand(100..1000),
    farm_yield: 45,
    user_id: 1
  }

]
farms.each do |farm|
  Farm.create!(farm)
end
