class CreateUserCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_categories do |t|
      t.belongs_to :user, null: false
      t.belongs_to :category, null: false
      t.timestamps
    end
  end
end
