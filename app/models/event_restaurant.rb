class EventRestaurant < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :event
  validates :event_id, uniqueness: { scope: :restaurant_id }

  attr_accessor :match_size
  after_initialize :set_attr

  def set_attr
    self.match_size = self.match.size
  end
end
