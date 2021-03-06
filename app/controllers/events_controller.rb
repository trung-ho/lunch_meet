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
        FindBestRestaurants.new.call(event: @event)
        redirect_to review_group_event_path(@group, @event), flash: { success: 'Your Event has been created successfully'}
      else
        render :new
      end
    else
      redirect_to(groups_path, error: 'Invalid Group')
    end
  end

  def find_restaurants
    @group = current_user.groups.find_by(id: group_id)
    return redirect_to root_path, flash: { error: 'Your don"t have permission'} if @group.nil?

    @event = @group.events.find_by(id: event_id)
    if @event.present?
      FindBestRestaurants.new.call(event: @event)
      redirect_to review_group_event_path(@group, @event)
    else
      redirect_to root_path, flash: { error: 'Your don"t have permission'}
    end
  end

  def review
    @group = current_user.groups.find_by(id: group_id)
    return redirect_to root_path, flash: { error: 'Your don"t have permission'} if @group.nil?
    @event = @group.events.find_by(id: event_id)
    return redirect_to root_path, flash: { error: 'Your don"t have permission'} if @event.nil?
    @members = @group.all_members
    @event_restaurants = @event.event_restaurants.includes(restaurant: [:categories])
  end

  def show
    @event = get_event
  end

  def edit
    @event = get_event
  end

  def update
    user_action = params['commit'].downcase
    @group = current_user.groups.find_by(id: group_id)
    return redirect_to root_path, flash: { error: 'Your don"t have permission'} if @group.nil?
    @event = @group.events.find_by(id: event_id)
    return redirect_to root_path, flash: { error: 'Your don"t have permission'} if @event.nil?
    if @event.update_attributes event_params
      redirect_to @group, flash: { success: 'Your Event has been updated successfully'}
    else
      redirect_to @group, flash: { error: 'Fail to update Event'}
    end
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
    params.require(:event).permit(:title, :description, :start_at, :radius, :vote_duration, :address, :latitude, :longitude, :group_id, :state)
  end
end