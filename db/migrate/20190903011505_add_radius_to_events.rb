class AddRadiusToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :radius, :integer
  end
end
