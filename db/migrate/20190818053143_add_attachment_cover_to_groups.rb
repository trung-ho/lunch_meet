class AddAttachmentCoverToGroups < ActiveRecord::Migration[5.2]
  def self.up
    change_table :groups do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :groups, :cover
  end
end
