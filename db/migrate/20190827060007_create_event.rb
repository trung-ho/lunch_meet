class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :start_at
      t.datetime :vote_end_at
      t.integer :vote_duration
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.belongs_to :group, null: false

      t.timestamps
    end
  end
end
