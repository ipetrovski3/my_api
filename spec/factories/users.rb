# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'customer@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    address { 'Narodni Heroi 13, Skopje' }
  end
end
