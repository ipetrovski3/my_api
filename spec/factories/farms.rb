# frozen_string_literal: true

FactoryBot.define do
  factory :farm do
    address { 'Narodni Heroi 13b' }
    farm_yield { 30 }
    size { 1000 }
  end
end
