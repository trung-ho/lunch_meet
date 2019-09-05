class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find user_id
  end

  def dashboard
  end

  def select_preferences
    @user = current_user
  end

  def set_preferences
  end

  private

  def user_id
    params['id']
  end

  def preferences_params
  end
end