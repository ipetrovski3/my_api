# frozen_string_literal: true

class AddAddressAndCoordinatesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address, :string
    add_column :users, :latitude, :string
    add_column :users, :longitude, :string
  end
end
