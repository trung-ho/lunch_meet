class Voting < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  belongs_to :event
end
