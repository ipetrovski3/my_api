# frozen_string_literal: true

class CreateFarms < ActiveRecord::Migration[5.2]
  def change
    create_table :farms do |t|
      t.string :address
      t.string :longtitude
      t.string :latitude
      t.integer :size
      t.integer :farm_yield
      t.boolean :outliers, default: false
      t.integer :distance, default: 0
      t.references :user

      t.timestamps
    end
  end
end
