class RestaurantCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :restaurant
end
