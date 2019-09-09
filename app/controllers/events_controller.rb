class EventsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @group = find_group
    @event = @group.events.new
  end

  def create
    @group = current_user.groups.where(id: group_id).last
    if @group.present?
      @event = @group.events.new event_params
      if @event.save
        redirect_to @group, flash: { success: 'Your Event has been created successfully'}
      else
        render :new
      end
    else
      redirect_to(groups_path, error: 'Invalid Group')
    end
  end

  def find_restaurants
    group = current_user.groups.find_by(id: group_id)
    return redirect_to root_path, flash: { error: 'Your don"t have permission'} if group.nil?

    event = group.events.find_by(id: event_id)
    if event.present?
      FindBestRestaurants.new.call(event: event)
    else
      redirect_to root_path, flash: { error: 'Your don"t have permission'}
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
    params.require(:event).permit(:title, :description, :start_at, :radius, :vote_duration, :address, :latitude, :longitude, :group_id)
  end
end