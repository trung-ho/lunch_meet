class CreateVoting < ActiveRecord::Migration[5.2]
  def change
    create_table :votings do |t|
      t.belongs_to :user, null: false
      t.belongs_to :event, null: false
      t.belongs_to :restaurant, null: false
      t.timestamps
    end
  end
end
