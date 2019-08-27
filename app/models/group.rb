class Group < ActiveRecord::Base
  belongs_to :admin, class_name: 'User', foreign_key: :user_id
  has_many :group_members
  has_many :members, through: :group_members, source: :member

  DEFAULT_URL = "#{Rails.env}/:class/:attachment/:id/:style_:basename.:extension"
  has_attached_file :cover,  styles: { medium: "300x300#", thumb: "100x100#" },
                              path: DEFAULT_URL,
                              s3_protocol: :https,
                              default_url: "groups/missing.svg"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
end
