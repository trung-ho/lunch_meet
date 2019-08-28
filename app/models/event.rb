class Event < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :title, :description, :start_at, :vote_duration
end
