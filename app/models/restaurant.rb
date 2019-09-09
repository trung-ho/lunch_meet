class Restaurant < ActiveRecord::Base
  has_many :restaurant_categories, dependent: :destroy
  has_many :categories, through: :restaurant_categories
  has_many :event_restaurants
  has_many :events, through: :event_restaurants
  has_many :votings

  geocoded_by :address1
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
