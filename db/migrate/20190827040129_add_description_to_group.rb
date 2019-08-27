class AddDescriptionToGroup < ActiveRecord::Migration[5.2]
  def change
    change_table :groups do |t|
      t.text :description
    end
  end
end
