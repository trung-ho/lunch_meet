class GroupsController < ActionController::Base
  def index
  	@groups = Group.all
  end
end