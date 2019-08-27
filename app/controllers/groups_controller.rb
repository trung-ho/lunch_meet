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
  end

  def create
  end

  def new
  end

  private

  def group_id
    params[:id]
  end

  def find_group
    Group.find group_id
  end

  # def params
  #   params.permit(:name, :description, :cover)
  # end
end