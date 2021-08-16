# frozen_string_literal: true

Google::Maps.configure do |config|
  config.authentication_mode = Google::Maps::Configuration::API_KEY
  config.api_key = ENV['GOOGLE_API_KEY']
end
