class GroupsController < ApplicationController
  def index
    @q = current_user.groups.ransack(params[:q])
    @groups = @q.result(distinct: true).order(created_at: :desc)
  end

  def show
    @group = find_group
  end

  def edit
    @group = find_group
  end

  def update
    @group = find_group

    if @group.update_attributes group_params
      redirect_to @group, flash: { success: 'Your Group has been updated successfull'}
    else
      render :edit
    end
  end

  def create
    @group = current_user.groups.new group_params

    if @group.save
      redirect_to @group, flash: { success: 'Your Group has been created successfull'}
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