class CreateRestaurant < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :alias
      t.string :name
      t.string :image
      t.string :url
      t.float :rating
      t.string :price
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :city
      t.string :zip_code
      t.string :country
      t.string :state
      t.string :display_address
      t.string :phone
      t.string :display_phone
      t.string :provider
      t.string :resource_id

      t.timestamps
    end
  end
end
