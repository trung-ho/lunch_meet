class VotingsController < ApplicationController
  def new
    @group = Group.find group_id
    @event = @group.events.find_by(id: event_id)
    @event_restaurants = @event.event_restaurants.includes(restaurant: [:categories])
    @members = @group.all_members
    @voting = current_user.votings.new event: @event
  end

  def create
    @group = Group.find group_id
    @voting = current_user.votings.new voting_params
    if @voting.save
      redirect_to @group, flash: { success: 'Voting successful.'}
    else
      render :new
    end
  end

  private

  def event_id
    params[:event_id]
  end

  def group_id
    params[:group_id]
  end

  def voting_params
    params.require(:voting).permit(:event_id, :restaurant_id)
  end
end