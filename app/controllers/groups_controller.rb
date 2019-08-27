class GroupsController < ApplicationController
  def index
    @q = current_user.groups.ransack(params[:q])
    @groups = @q.result(distinct: true).order(created_at: :desc)
  end
end