class Event < ActiveRecord::Base
  include AASM
  belongs_to :group
  has_many :event_restaurants
  has_many :restaurants, through: :event_restaurants
  validates_presence_of :title, :description, :start_at, :vote_duration

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode


  aasm column: :state do
    state :in_active, initial: true
    state :review
    state :active, :finished

    event :reviewing do
      transitions from: :in_active, to: :review
    end

    event :publish do
      transitions from: :reviewed, to: :active
    end

    event :close do
      transitions from: :active, to: :finished
    end
  end
end
