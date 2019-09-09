class EventRestaurant < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :event
  validates :event_id, uniqueness: { scope: :restaurant_id }
end
