class GroupsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @groups = Group.joins('LEFT OUTER JOIN "group_members" ON "group_members"."group_id" = "groups"."id"'
                          ).where("groups.user_id = ? or group_members.user_id = ?", current_user.id, current_user.id)
    @q = @groups.ransack(params[:q])
    @groups = @q.result(distinct: true).order(created_at: :desc)
  end

  def show
    @group = find_group
    @events = Event.joins('LEFT OUTER JOIN "groups" ON "groups"."id" = "events"."group_id"'
                          ).where("groups.id = ? AND (groups.user_id = ? OR events.state IN (?))", @group.id, current_user.id, ['active', 'finished']).order(start_at: :desc)
  end

  def edit
    @group = find_group
  end

  def update
    @group = find_group

    if @group.update_attributes group_params
      redirect_to @group, flash: { success: 'Your Group has been updated successfully'}
    else
      render :edit
    end
  end

  def create
    @group = current_user.groups.new group_params
    if @group.save
      redirect_to @group, flash: { success: 'Your Group has been created successfully'}
    else
      render :new
    end
  end

  def new
    @group = Group.new
  end

  private

  def group_id
    params[:id]
  end

  def find_group
    Group.find group_id
  end

  def group_params
    params.require(:group).permit(:name, :description, :cover)
  end
end