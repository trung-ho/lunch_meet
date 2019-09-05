class CreatEventRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :event_restaurants do |t|
      t.belongs_to :event, null: false
      t.belongs_to :restaurant, null: false
      t.float :distant
      t.float :match
      t.timestamps
    end
  end
end
