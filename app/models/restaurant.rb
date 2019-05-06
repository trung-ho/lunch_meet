class Restaurant < ActiveRecord::Base
  has_many :restaurant_categories
  has_many :categories, through: :restaurant_categories
end
