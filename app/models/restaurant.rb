class Restaurant < ActiveRecord::Base
  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories

  geocoded_by :address1
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
