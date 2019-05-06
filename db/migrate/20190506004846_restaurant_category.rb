class RestaurantCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_categories do |t|
      t.belongs_to :restaurant, null: false
      t.belongs_to :category, null: false
      t.timestamps
    end
  end
end
