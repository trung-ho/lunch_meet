class EventsController < ApplicationController
  def new
    @group = find_group
    @event = @group.events.new
  end

  def create
    @group = current_user.groups.where(id: group_id).last
    if @group.present?
      @event = @group.events.new event_params
      if @event.save
        redirect_to(@group, error: 'Event is created successful.')
      else
        render :new
      end
    else
      redirect_to(groups_path, error: 'Invalid Group')
    end
  end

  def show
    @event = get_event
  end

  def edit
    @event = get_event
  end

  def update
    @event = get_event
  end

  private

  def event_id
    params[:id]
  end

  def find_event
    Event.find event_id
  end

  def group_id
    params[:group_id]
  end

  def find_group
    Group.find group_id
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_at, :vote_end_at, :vote_duration, :address, :latitude, :longitude, :group_id)
  end
end