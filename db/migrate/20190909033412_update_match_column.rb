class UpdateMatchColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :event_restaurants, :match
    add_column :event_restaurants, :match, :string, array: true, default: []
  end
end
