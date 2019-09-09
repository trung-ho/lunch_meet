class Group < ActiveRecord::Base
  belongs_to :admin, class_name: 'User', foreign_key: :user_id
  has_many :group_members
  has_many :members, through: :group_members, source: :member
  has_many :events

  DEFAULT_URL = "#{Rails.env}/:class/:attachment/:id/:style_:basename.:extension"
  COVER_TYPE = /\Aimage\/.*\z/
  has_attached_file :cover,  styles: { medium: "300x300#", thumb: "100x100#" },
                              path: DEFAULT_URL,
                              s3_protocol: :https,
                              default_url: "groups/missing.svg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
  validates_presence_of :name

  def all_members
    (self.members.to_a << self.admin).uniq
  end

  def all_members_id
    (self.members.pluck(:id) << self.user_id).uniq
  end
end
