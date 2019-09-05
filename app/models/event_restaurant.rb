class EventRestaurant < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :event
end
