class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.belongs_to :user, null: false
      t.belongs_to :group, null: false
      
      t.timestamps
    end
  end
end
