class AddDistanceColumnToEventRestaurant < ActiveRecord::Migration[5.2]
  def change
    remove_column :event_restaurants, :distant
    add_column :event_restaurants, :distance, :float
  end
end
