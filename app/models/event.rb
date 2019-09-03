class Event < ActiveRecord::Base
  include AASM
  belongs_to :group
  validates_presence_of :title, :description, :start_at, :vote_duration

  aasm column: :state do
    state :in_active, initial: true
    state :active, :finished

    event :publish do
      transitions from: :in_active, to: :active
    end

    event :close do
      transitions from: :active, to: :finished
    end
  end
end
