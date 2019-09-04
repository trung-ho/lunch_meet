class Category < ActiveRecord::Base
  has_many :restaurant_categories
  has_many :restaurants, through: :restaurant_categories

  has_many :user_categories
  has_many :users, through: :user_categories
  validates_uniqueness_of :alias
end
