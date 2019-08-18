class AddLatLongToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :latitude, :decimal
    add_column :restaurants, :longitude, :decimal
    add_column :restaurants, :provider_id, :string
    remove_column :restaurants, :resource_id
  end
end
