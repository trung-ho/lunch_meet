class Group < ActiveRecord::Base
  belongs_to :admin, class_name: 'User', foreign_key: :user_id
  has_many :group_members
  has_many :members, through: :group_members, source: :member
end
