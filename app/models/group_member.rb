class GroupMember < ActiveRecord::Base
  belongs_to :member, class_name: 'User', foreign_key: :user_id
  belongs_to :group, class_name: 'Group', foreign_key: :group_id
  validates :group, uniqueness: { scope: :member }
end
