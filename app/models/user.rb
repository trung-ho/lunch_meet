class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  DEFAULT_URL = "#{Rails.env}/:class/:attachment/:id/:style_:basename.:extension"
  has_attached_file :avatar,  styles: { medium: "300x300>", thumb: "100x100>" },
                              path: DEFAULT_URL,
                              s3_protocol: :https,
                              default_url: "users/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
