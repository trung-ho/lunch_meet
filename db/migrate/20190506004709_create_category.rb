class CreateCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :alias
      t.string :name
      t.timestamps
    end
  end
end
