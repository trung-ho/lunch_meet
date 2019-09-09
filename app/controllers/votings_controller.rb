class VotingsController < ApplicationController
  def new
    @group = Group.find group_id
    @event = @group.events.find_by(id: event_id)
    @event_restaurants = @event.event_restaurants.includes(restaurant: [:categories])
    @members = @group.all_members
  end

  private

  def event_id
    params[:event_id]
  end

  def group_id
    params[:group_id]
  end
end