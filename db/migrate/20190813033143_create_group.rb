class CreateGroup < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
    	t.string :name
    	t.belongs_to :user, null: false
    	
    	t.timestamps
    end
  end
end
